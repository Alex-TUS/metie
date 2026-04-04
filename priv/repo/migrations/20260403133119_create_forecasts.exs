defmodule Metie.Repo.Migrations.CreateForecasts do
  use Ecto.Migration

  def change do
    create table(:forecasts) do
      add :timestamp, :utc_datetime, null: false
      add :run_start, :utc_datetime, null: false
      add :run_finish, :utc_datetime, null: false
      add :run_next, :utc_datetime, null: false
      add :weather_model, :string, null: false
      add :altitude, :integer, null: false
      add :latitude, :float, null: false
      add :longitude, :float, null: false
      add :temperature, :float, null: false
      add :dewpoint_temperature, :float, null: false
      add :weather_symbol, :integer, null: false
      add :wind_direction, :float, null: false
      add :wind_speed, :float, null: false
      add :wind_beaufort, :integer, null: false
      add :wind_gust, :float, null: false
      add :humidity, :float, null: false
      add :pressure, :float, null: false
      add :cloudiness, :float, null: false
      add :low_clouds, :float, null: false
      add :medium_clouds, :float, null: false
      add :high_clouds, :float, null: false
      add :global_radiation, :float, null: false
      add :precipitation, :float, null: false
      add :precipitation_min, :float, null: false
      add :precipitation_max, :float, null: false
      add :precipitation_probability, :float, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:forecasts, [:timestamp, :latitude, :longitude])
  end
end
