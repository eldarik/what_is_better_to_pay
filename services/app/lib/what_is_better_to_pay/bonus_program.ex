defmodule WhatIsBetterToPay.BonusProgram do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "bonus_programs" do
    field(:card_title, :string)
    field(:multipurpose, :boolean)
    field(:percentage, :decimal)
    field(:state, :string)

    timestamps()

    belongs_to :user, WhatIsBetterToPay.User
    belongs_to :category, WhatIsBetterToPay.Category
    belongs_to :place, WhatIsBetterToPay.Place
  end

    def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,
      [
        :card_title,
        :multipurpose,
        :percentage,
        :state,
        :user_id,
        :category_id,
        :place_id
      ]
    )
    |> validate_required(
      [
        :card_title,
        :multipurpose,
        :percentage,
        :state,
        :user_id,
      ]
    )
  end

  def settings_changeset(object, params \\ %{}) do
    object
    |> cast(
      params,
      [
        :card_title,
        :multipurpose,
        :percentage,
        :state,
        :user_id,
        :category_id,
        :place_id
      ],
      []
    )
  end
end
