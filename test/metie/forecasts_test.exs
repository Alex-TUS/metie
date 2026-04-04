defmodule Metie.ForecastsTest do
  use Metie.DataCase

  alias Metie.Forecasts

  describe "forecasts" do
    alias Metie.Forecasts.Forecast

    import Metie.ForecastsFixtures

    @invalid_attrs %{
      timestamp: nil,
      run_start: nil,
      run_finish: nil,
      run_next: nil,
      altitude: nil,
      latitude: nil,
      longitude: nil,
      temperature: nil,
      dewpoint_temperature: nil,
      weather_symbol: nil,
      wind_direction: nil,
      wind_speed: nil,
      wind_beaufort: nil,
      wind_gust: nil,
      humidity: nil,
      pressure: nil,
      cloudiness: nil,
      low_clouds: nil,
      medium_clouds: nil,
      high_clouds: nil,
      global_radiation: nil,
      precipitation: nil,
      precipitation_min: nil,
      precipitation_max: nil,
      precipitation_probability: nil
    }

    test "list_forecasts/0 returns all forecasts" do
      forecast = forecast_fixture()
      assert Forecasts.list_forecasts() == [forecast]
    end

    test "get_forecast!/1 returns the forecast with given id" do
      forecast = forecast_fixture()
      assert Forecasts.get_forecast!(forecast.id) == forecast
    end

    test "create_forecast/1 with valid data creates a forecast" do
      valid_attrs = %{
        timestamp: ~U[2026-04-03 10:30:00Z],
        run_start: ~U[2026-04-03 10:30:00Z],
        run_finish: ~U[2026-04-03 10:30:00Z],
        run_next: ~U[2026-04-03 10:30:00Z],
        altitude: 42,
        latitude: 120.5,
        longitude: 120.5,
        temperature: 120.5,
        dewpoint_temperature: 120.5,
        weather_symbol: 42,
        weather_model: :harmonie,
        wind_direction: 120.5,
        wind_speed: 120.5,
        wind_beaufort: 42,
        wind_gust: 120.5,
        humidity: 120.5,
        pressure: 120.5,
        cloudiness: 120.5,
        low_clouds: 120.5,
        medium_clouds: 120.5,
        high_clouds: 120.5,
        global_radiation: 120.5,
        precipitation: 120.5,
        precipitation_min: 120.5,
        precipitation_max: 120.5,
        precipitation_probability: 120.5
      }

      assert {:ok, %Forecast{} = forecast} = Forecasts.create_forecast(valid_attrs)
      assert forecast.timestamp == ~U[2026-04-03 10:30:00Z]
      assert forecast.run_start == ~U[2026-04-03 10:30:00Z]
      assert forecast.run_finish == ~U[2026-04-03 10:30:00Z]
      assert forecast.run_next == ~U[2026-04-03 10:30:00Z]
      assert forecast.altitude == 42
      assert forecast.latitude == 120.5
      assert forecast.longitude == 120.5
      assert forecast.temperature == 120.5
      assert forecast.dewpoint_temperature == 120.5
      assert forecast.weather_symbol == 42
      assert forecast.weather_model == :harmonie
      assert forecast.wind_direction == 120.5
      assert forecast.wind_speed == 120.5
      assert forecast.wind_beaufort == 42
      assert forecast.wind_gust == 120.5
      assert forecast.humidity == 120.5
      assert forecast.pressure == 120.5
      assert forecast.cloudiness == 120.5
      assert forecast.low_clouds == 120.5
      assert forecast.medium_clouds == 120.5
      assert forecast.high_clouds == 120.5
      assert forecast.global_radiation == 120.5
      assert forecast.precipitation == 120.5
      assert forecast.precipitation_min == 120.5
      assert forecast.precipitation_max == 120.5
      assert forecast.precipitation_probability == 120.5
    end

    test "create_forecast/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forecasts.create_forecast(@invalid_attrs)
    end

    test "update_forecast/2 with valid data updates the forecast" do
      forecast = forecast_fixture()

      update_attrs = %{
        timestamp: ~U[2026-04-04 10:30:00Z],
        run_start: ~U[2026-04-04 10:30:00Z],
        run_finish: ~U[2026-04-04 10:30:00Z],
        run_next: ~U[2026-04-04 10:30:00Z],
        altitude: 43,
        latitude: 456.7,
        longitude: 456.7,
        temperature: 456.7,
        dewpoint_temperature: 456.7,
        weather_symbol: 43,
        weather_model: :ecmwf1,
        wind_direction: 456.7,
        wind_speed: 456.7,
        wind_beaufort: 43,
        wind_gust: 456.7,
        humidity: 456.7,
        pressure: 456.7,
        cloudiness: 456.7,
        low_clouds: 456.7,
        medium_clouds: 456.7,
        high_clouds: 456.7,
        global_radiation: 456.7,
        precipitation: 456.7,
        precipitation_min: 456.7,
        precipitation_max: 456.7,
        precipitation_probability: 456.7
      }

      assert {:ok, %Forecast{} = forecast} = Forecasts.update_forecast(forecast, update_attrs)
      assert forecast.timestamp == ~U[2026-04-04 10:30:00Z]
      assert forecast.run_start == ~U[2026-04-04 10:30:00Z]
      assert forecast.run_finish == ~U[2026-04-04 10:30:00Z]
      assert forecast.run_next == ~U[2026-04-04 10:30:00Z]
      assert forecast.altitude == 43
      assert forecast.latitude == 456.7
      assert forecast.longitude == 456.7
      assert forecast.temperature == 456.7
      assert forecast.dewpoint_temperature == 456.7
      assert forecast.weather_symbol == 43
      assert forecast.weather_model == :ecmwf1
      assert forecast.wind_direction == 456.7
      assert forecast.wind_speed == 456.7
      assert forecast.wind_beaufort == 43
      assert forecast.wind_gust == 456.7
      assert forecast.humidity == 456.7
      assert forecast.pressure == 456.7
      assert forecast.cloudiness == 456.7
      assert forecast.low_clouds == 456.7
      assert forecast.medium_clouds == 456.7
      assert forecast.high_clouds == 456.7
      assert forecast.global_radiation == 456.7
      assert forecast.precipitation == 456.7
      assert forecast.precipitation_min == 456.7
      assert forecast.precipitation_max == 456.7
      assert forecast.precipitation_probability == 456.7
    end

    test "update_forecast/2 with invalid data returns error changeset" do
      forecast = forecast_fixture()
      assert {:error, %Ecto.Changeset{}} = Forecasts.update_forecast(forecast, @invalid_attrs)
      assert forecast == Forecasts.get_forecast!(forecast.id)
    end

    test "delete_forecast/1 deletes the forecast" do
      forecast = forecast_fixture()
      assert {:ok, %Forecast{}} = Forecasts.delete_forecast(forecast)
      assert_raise Ecto.NoResultsError, fn -> Forecasts.get_forecast!(forecast.id) end
    end

    test "change_forecast/1 returns a forecast changeset" do
      forecast = forecast_fixture()
      assert %Ecto.Changeset{} = Forecasts.change_forecast(forecast)
    end
  end
end
