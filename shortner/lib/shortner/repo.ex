defmodule Shortner.Repo do
  use Ecto.Repo,
    otp_app: :shortner,
    adapter: Ecto.Adapters.Postgres
end
