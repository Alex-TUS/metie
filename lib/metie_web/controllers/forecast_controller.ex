defmodule MetieWeb.ForecastController do
  use MetieWeb, :controller

  alias Metie.Forecasts
  alias Metie.Forecasts.Forecast

  action_fallback MetieWeb.FallbackController

  def index(conn, _params) do
    forecasts = Forecasts.list_recent_forecasts()
    render(conn, :index, forecasts: forecasts)
  end

  def create(conn, %{"forecast" => forecast_params}) do
    with {:ok, %Forecast{} = forecast} <- Forecasts.create_forecast(forecast_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/forecasts/#{forecast}")
      |> render(:show, forecast: forecast)
    end
  end

  def show(conn, %{"id" => id}) do
    forecast = Forecasts.get_forecast!(id)
    render(conn, :show, forecast: forecast)
  end

  def update(conn, %{"id" => id, "forecast" => forecast_params}) do
    forecast = Forecasts.get_forecast!(id)

    with {:ok, %Forecast{} = forecast} <- Forecasts.update_forecast(forecast, forecast_params) do
      render(conn, :show, forecast: forecast)
    end
  end

  def delete(conn, %{"id" => id}) do
    forecast = Forecasts.get_forecast!(id)

    with {:ok, %Forecast{}} <- Forecasts.delete_forecast(forecast) do
      send_resp(conn, :no_content, "")
    end
  end
end
