defmodule MetieWeb.ForecastControllerTest do
  use MetieWeb.ConnCase

  import Metie.ForecastsFixtures
  alias Metie.Forecasts.Forecast

  @create_attrs %{
    mode: "some mode"
  }
  @update_attrs %{
    mode: "some updated mode"
  }
  @invalid_attrs %{mode: nil}

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
               "mode" => "some mode"
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
               "mode" => "some updated mode"
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
