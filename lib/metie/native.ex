defmodule Metie.Native do
  @moduledoc false

  use Rustler, otp_app: :metie, crate: "metie_nif"

  def parse(_binary), do: err()

  defp err, do: :erlang.nif_error(:nif_not_loaded)
end
