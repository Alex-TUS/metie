defmodule Metie.ForecastsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Metie.Forecasts` context.
  """

  @doc """
  Generate a forecast.
  """
  def forecast_fixture(attrs \\ %{}) do
    {:ok, forecast} =
      attrs
      |> Enum.into(%{
        altitude: 42,
        cloudiness: 120.5,
        dewpoint_temperature: 120.5,
        global_radiation: 120.5,
        high_clouds: 120.5,
        humidity: 120.5,
        latitude: 120.5,
        longitude: 120.5,
        low_clouds: 120.5,
        medium_clouds: 120.5,
        precipitation: 120.5,
        precipitation_max: 120.5,
        precipitation_min: 120.5,
        precipitation_probability: 120.5,
        pressure: 120.5,
        run_finish: ~U[2026-04-03 10:30:00Z],
        run_next: ~U[2026-04-03 10:30:00Z],
        run_start: ~U[2026-04-03 10:30:00Z],
        temperature: 120.5,
        timestamp: ~U[2026-04-03 10:30:00Z],
        weather_symbol: 42,
        weather_model: :harmonie,
        wind_beaufort: 42,
        wind_direction: 120.5,
        wind_gust: 120.5,
        wind_speed: 120.5
      })
      |> Metie.Forecasts.create_forecast()

    forecast
  end
end
