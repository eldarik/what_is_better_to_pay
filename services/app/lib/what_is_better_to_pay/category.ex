defmodule WhatIsBetterToPay.Category do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field(:title, :string)

    timestamps()
  end

    def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

  def settings_changeset(object, params \\ %{}) do
    object
    |> cast(params, [:title], [])
    |> unique_constraint(:title)
  end
end
