defmodule Metie.Repo do
  use Ecto.Repo,
    otp_app: :metie,
    adapter: Ecto.Adapters.Postgres
end
