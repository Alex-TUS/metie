defmodule Metie.Forecasts do
  @moduledoc """
  The Forecasts context.
  """

  import Ecto.Query, warn: false
  alias Metie.Repo

  alias Metie.Forecasts.Forecast

  @doc """
  Returns the list of forecasts.

  ## Examples

      iex> list_forecasts()
      [%Forecast{}, ...]

  """
  def list_forecasts do
    Repo.all(Forecast)
  end

  @doc """
  Gets a single forecast.

  Raises `Ecto.NoResultsError` if the Forecast does not exist.

  ## Examples

      iex> get_forecast!(123)
      %Forecast{}

      iex> get_forecast!(456)
      ** (Ecto.NoResultsError)

  """
  def get_forecast!(id), do: Repo.get!(Forecast, id)

  @doc """
  Creates a forecast.

  ## Examples

      iex> create_forecast(%{field: value})
      {:ok, %Forecast{}}

      iex> create_forecast(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_forecast(attrs) do
    %Forecast{}
    |> Forecast.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a forecast.

  ## Examples

      iex> update_forecast(forecast, %{field: new_value})
      {:ok, %Forecast{}}

      iex> update_forecast(forecast, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_forecast(%Forecast{} = forecast, attrs) do
    forecast
    |> Forecast.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a forecast.

  ## Examples

      iex> delete_forecast(forecast)
      {:ok, %Forecast{}}

      iex> delete_forecast(forecast)
      {:error, %Ecto.Changeset{}}

  """
  def delete_forecast(%Forecast{} = forecast) do
    Repo.delete(forecast)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking forecast changes.

  ## Examples

      iex> change_forecast(forecast)
      %Ecto.Changeset{data: %Forecast{}}

  """
  def change_forecast(%Forecast{} = forecast, attrs \\ %{}) do
    Forecast.changeset(forecast, attrs)
  end
end
