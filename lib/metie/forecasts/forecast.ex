defmodule Metie.Forecasts.Forecast do
  use Ecto.Schema
  import Ecto.Changeset

  schema "forecasts" do
    field :timestamp, :utc_datetime
    field :run_start, :utc_datetime
    field :run_finish, :utc_datetime
    field :run_next, :utc_datetime
    field :weather_model, Ecto.Enum, values: [:harmonie, :ecmwf1, :ecmwf2, :ecmwf3, :unknown]
    field :altitude, :integer
    field :latitude, :float
    field :longitude, :float
    field :temperature, :float
    field :dewpoint_temperature, :float
    field :weather_symbol, :integer
    field :wind_direction, :float
    field :wind_speed, :float
    field :wind_beaufort, :integer
    field :wind_gust, :float
    field :humidity, :float
    field :pressure, :float
    field :cloudiness, :float
    field :low_clouds, :float
    field :medium_clouds, :float
    field :high_clouds, :float
    field :global_radiation, :float
    field :precipitation, :float
    field :precipitation_min, :float
    field :precipitation_max, :float
    field :precipitation_probability, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(forecast, attrs) do
    fields =
      __MODULE__.__schema__(:fields) |> Enum.reject(&(&1 in [:id, :inserted_at, :updated_at]))

    forecast
    |> cast(attrs, fields)
    |> validate_required(fields)
  end
end
