defmodule WhatIsBetterToPay.SimilarCategory do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "similar_categories" do

    belongs_to :left_category, WhatIsBetterToPay.Category,
      [foreign_key: :left_category_id]
    belongs_to :right_category, WhatIsBetterToPay.Category,
      [foreign_key: :right_category_id]
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:left_category_id, :right_category_id])
    |> validate_required([:left_category_id, :right_category_id])
  end

  def settings_changeset(object, params \\ %{}) do
    object
    |> cast(params, [:left_category_id, :right_category_id], [])
  end
end
