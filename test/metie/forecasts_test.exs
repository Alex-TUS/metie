defmodule Metie.ForecastsTest do
  use Metie.DataCase

  alias Metie.Forecasts

  describe "forecasts" do
    alias Metie.Forecasts.Forecast

    import Metie.ForecastsFixtures

    @invalid_attrs %{mode: nil}

    test "list_forecasts/0 returns all forecasts" do
      forecast = forecast_fixture()
      assert Forecasts.list_forecasts() == [forecast]
    end

    test "get_forecast!/1 returns the forecast with given id" do
      forecast = forecast_fixture()
      assert Forecasts.get_forecast!(forecast.id) == forecast
    end

    test "create_forecast/1 with valid data creates a forecast" do
      valid_attrs = %{mode: "some mode"}

      assert {:ok, %Forecast{} = forecast} = Forecasts.create_forecast(valid_attrs)
      assert forecast.mode == "some mode"
    end

    test "create_forecast/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forecasts.create_forecast(@invalid_attrs)
    end

    test "update_forecast/2 with valid data updates the forecast" do
      forecast = forecast_fixture()
      update_attrs = %{mode: "some updated mode"}

      assert {:ok, %Forecast{} = forecast} = Forecasts.update_forecast(forecast, update_attrs)
      assert forecast.mode == "some updated mode"
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
