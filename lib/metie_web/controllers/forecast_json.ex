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
      timestamp: forecast.timestamp,
      run_start: forecast.run_start,
      run_finish: forecast.run_finish,
      run_next: forecast.run_next,
      altitude: forecast.altitude,
      weather_model: forecast.weather_model,
      latitude: forecast.latitude,
      longitude: forecast.longitude,
      temperature: forecast.temperature,
      dewpoint_temperature: forecast.dewpoint_temperature,
      weather_symbol: forecast.weather_symbol,
      wind_direction: forecast.wind_direction,
      wind_speed: forecast.wind_speed,
      wind_beaufort: forecast.wind_beaufort,
      wind_gust: forecast.wind_gust,
      humidity: forecast.humidity,
      pressure: forecast.pressure,
      cloudiness: forecast.cloudiness,
      low_clouds: forecast.low_clouds,
      medium_clouds: forecast.medium_clouds,
      high_clouds: forecast.high_clouds,
      global_radiation: forecast.global_radiation,
      precipitation: forecast.precipitation,
      precipitation_min: forecast.precipitation_min,
      precipitation_max: forecast.precipitation_max,
      precipitation_probability: forecast.precipitation_probability
    }
  end
end
