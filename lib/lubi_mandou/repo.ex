defmodule LubiMandou.Repo do
  use Ecto.Repo,
    otp_app: :lubi_mandou,
    adapter: Ecto.Adapters.Postgres
end
