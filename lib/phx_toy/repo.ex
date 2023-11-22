defmodule PhxToy.Repo do
  use Ecto.Repo,
    otp_app: :phx_toy,
    adapter: Ecto.Adapters.Postgres
end
