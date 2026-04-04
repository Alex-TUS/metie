defmodule Metie.Client do
  require Logger

  @base_url "http://openaccess.pf.api.met.ie/metno-wdb2ts/locationforecast"

  def fetch_forecasts(params) do
    url = build_url(params)

    Logger.debug("Fetching forecasts #{url}")

    {:ok, forecasts} =
      url
      |> Req.get!()
      |> Map.fetch!(:body)
      |> Metie.Native.parse()

    forecasts
  end

  defp build_url(params) do
    query = URI.encode_query(params)

    @base_url
    |> URI.parse()
    |> URI.append_query(query)
  end
end

defmodule Metie.Client.Worker do
  use GenServer

  # Client

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Server (callbacks)

  @impl true
  def init(opts) do
    lat = Keyword.get(opts, :lat)
    long = Keyword.get(opts, :long)

    schedule_work(:timer.seconds(5))

    {:ok, %{lat: lat, long: long}}
  end

  @impl true
  def handle_info(:work, coords) do
    coords
    |> Metie.Client.fetch_forecasts()
    |> Enum.map(&Map.from_struct/1)
    |> Enum.map(&Metie.Forecasts.create_forecast/1)

    schedule_work()

    {:noreply, coords}
  end

  defp schedule_work(interval \\ :timer.minutes(30)) do
    Process.send_after(self(), :work, interval)
  end
end
