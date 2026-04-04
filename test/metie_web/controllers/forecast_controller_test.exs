defmodule MetieWeb.ForecastControllerTest do
  use MetieWeb.ConnCase

  import Metie.ForecastsFixtures
  alias Metie.Forecasts.Forecast

  @create_attrs %{
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
    wind_direction: 120.5,
    wind_speed: 120.5,
    weather_model: :harmonie,
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
  @update_attrs %{
    timestamp: ~U[2026-04-04 10:30:00Z],
    run_start: ~U[2026-04-04 10:30:00Z],
    run_finish: ~U[2026-04-04 10:30:00Z],
    run_next: ~U[2026-04-04 10:30:00Z],
    altitude: 43,
    latitude: 456.7,
    longitude: 456.7,
    temperature: 456.7,
    dewpoint_temperature: 456.7,
    weather_model: :ecmwf1,
    weather_symbol: 43,
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

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all forecasts", %{conn: conn} do
      conn = get(conn, ~p"/api/forecasts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create forecast" do
    test "renders forecast when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/forecasts", forecast: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/forecasts/#{id}")

      assert %{
               "id" => ^id,
               "altitude" => 42,
               "cloudiness" => 120.5,
               "dewpoint_temperature" => 120.5,
               "global_radiation" => 120.5,
               "high_clouds" => 120.5,
               "humidity" => 120.5,
               "latitude" => 120.5,
               "longitude" => 120.5,
               "low_clouds" => 120.5,
               "medium_clouds" => 120.5,
               "precipitation" => 120.5,
               "precipitation_max" => 120.5,
               "precipitation_min" => 120.5,
               "precipitation_probability" => 120.5,
               "pressure" => 120.5,
               "run_finish" => "2026-04-03T10:30:00Z",
               "run_next" => "2026-04-03T10:30:00Z",
               "run_start" => "2026-04-03T10:30:00Z",
               "temperature" => 120.5,
               "timestamp" => "2026-04-03T10:30:00Z",
               "weather_model" => "harmonie",
               "weather_symbol" => 42,
               "wind_beaufort" => 42,
               "wind_direction" => 120.5,
               "wind_gust" => 120.5,
               "wind_speed" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/forecasts", forecast: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update forecast" do
    setup [:create_forecast]

    test "renders forecast when data is valid", %{
      conn: conn,
      forecast: %Forecast{id: id} = forecast
    } do
      conn = put(conn, ~p"/api/forecasts/#{forecast}", forecast: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/forecasts/#{id}")

      assert %{
               "id" => ^id,
               "altitude" => 43,
               "cloudiness" => 456.7,
               "dewpoint_temperature" => 456.7,
               "global_radiation" => 456.7,
               "high_clouds" => 456.7,
               "humidity" => 456.7,
               "latitude" => 456.7,
               "longitude" => 456.7,
               "low_clouds" => 456.7,
               "medium_clouds" => 456.7,
               "precipitation" => 456.7,
               "precipitation_max" => 456.7,
               "precipitation_min" => 456.7,
               "precipitation_probability" => 456.7,
               "pressure" => 456.7,
               "run_finish" => "2026-04-04T10:30:00Z",
               "run_next" => "2026-04-04T10:30:00Z",
               "run_start" => "2026-04-04T10:30:00Z",
               "temperature" => 456.7,
               "timestamp" => "2026-04-04T10:30:00Z",
               "weather_symbol" => 43,
               "wind_beaufort" => 43,
               "wind_direction" => 456.7,
               "wind_gust" => 456.7,
               "wind_speed" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, forecast: forecast} do
      conn = put(conn, ~p"/api/forecasts/#{forecast}", forecast: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete forecast" do
    setup [:create_forecast]

    test "deletes chosen forecast", %{conn: conn, forecast: forecast} do
      conn = delete(conn, ~p"/api/forecasts/#{forecast}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/forecasts/#{forecast}")
      end
    end
  end

  defp create_forecast(_) do
    forecast = forecast_fixture()

    %{forecast: forecast}
  end
end
