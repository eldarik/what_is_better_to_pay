defmodule WhatIsBetterToPay.Place do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "places" do
    # field(:title, :string)
    # belongs_to :category, Category

    # timestamps()
  end

    def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :category_id])
    |> validate_required([:title, :category_id])
  end

  def settings_changeset(object, params \\ %{}) do
    object
    |> cast(params, [:title, :category_id], [])
    |> unique_constraint(:title)
  end
end
