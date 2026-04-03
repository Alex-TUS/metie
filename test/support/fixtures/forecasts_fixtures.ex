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
        mode: "some mode"
      })
      |> Metie.Forecasts.create_forecast()

    forecast
  end
end
