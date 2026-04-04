defmodule Metie.Client do
  @moduledoc """
  An implementation of a Metie.Client.Behaviour.
  """

  require Logger

  @base_url "http://openaccess.pf.api.met.ie/metno-wdb2ts/locationforecast"

  @behaviour Metie.Client.Behaviour

  @impl true
  def fetch_forecasts(%{lat: _, long: _} = params) do
    url = build_url(params)

    Logger.info("Fetching weather: #{url}")

    case Req.get(url) do
      {:ok, %{status: 200, body: body}} -> {:ok, body}
      error -> {:error, "Error fetching weather: #{inspect(error)}"}
    end
  end

  defp build_url(params) do
    query = URI.encode_query(params)

    @base_url
    |> URI.parse()
    |> URI.append_query(query)
  end
end

defmodule Metie.Client.Worker do
  @moduledoc false

  use GenServer

  require Logger

  @client Application.compile_env(:metie, :client, Metie.Client)

  # Client

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Server (callbacks)

  @impl true
  def init(opts) do
    lat = Keyword.get(opts, :latitude)
    long = Keyword.get(opts, :longitude)

    schedule_work(:timer.seconds(30))

    {:ok, %{lat: lat, long: long}}
  end

  @impl true
  def handle_info(:work, coords) do
    insert_all = fn forecasts ->
      forecasts
      |> Stream.map(&Map.from_struct/1)
      |> Stream.map(&Metie.Forecasts.create_forecast/1)
      |> Enum.split_with(&match?({:error, _}, &1))
    end

    with {:ok, weather} <- @client.fetch_forecasts(coords),
         {:ok, forecasts} <- Metie.Native.parse(weather) do
      {errored, ok} = insert_all.(forecasts)

      Logger.info("inserted: #{length(ok)}")

      errors =
        Enum.map(errored, fn {:error, changeset} ->
          MetieWeb.ChangesetJSON.error(%{changeset: changeset})
        end)

      unless Enum.empty?(errors) do
        Logger.error("errored: #{inspect(errors)}")
      end
    else
      {:error, error} -> Logger.error("Error fetching forecasts: #{error}")
    end

    schedule_work()

    {:noreply, coords}
  end

  defp schedule_work(interval \\ :timer.minutes(30)) do
    Process.send_after(self(), :work, interval)
  end
end

defmodule Metie.Client.Behaviour do
  @moduledoc false
  @callback fetch_forecasts(map()) :: {:ok, binary()} | {:error, binary()}
end
