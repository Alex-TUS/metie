defmodule MetieWeb.ForecastJSON do
  alias Metie.Forecasts.Forecast

  @doc """
  Renders a list of forecasts.
  """
  def index(%{forecasts: forecasts}) do
    %{data: for(forecast <- forecasts, do: data(forecast))}
  end

  @doc """
  Renders a single forecast.
  """
  def show(%{forecast: forecast}) do
    %{data: data(forecast)}
  end

  defp data(%Forecast{} = forecast) do
    %{
      id: forecast.id,
      mode: forecast.mode
    }
  end
end
