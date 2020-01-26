defmodule WhatIsBetterToPay.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:username, :string)
    field(:telegram_id, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:last_active_at, :naive_datetime)

    timestamps()
  end

    def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :username,
      :telegram_id,
      :first_name,
      :last_name,
    ])
    |> validate_required([:username, :telegram_id])
  end

  def settings_changeset(object, params \\ %{}) do
    object
    |> cast(params, [:username], [])
    |> unique_constraint(:username)
  end
end
