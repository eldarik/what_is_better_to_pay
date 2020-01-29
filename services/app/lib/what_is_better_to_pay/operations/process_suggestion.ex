defmodule WhatIsBetterToPay.Operations.ProcessSuggestion do
  import Ecto.Query, only: [from: 2]
  alias WhatIsBetterToPay.{Repo, User, Place, Category, BonusProgram}

  def execute(%User{} = user, %Category{} = category, %Place{} = place) do
  end

  def execute(%User{} = user, %Category{} = category) do
    bonus_programs = active_bonus_programs(user)
    found = bonus_programs |> program_by(category)

    bonus_programs |> result(found)
  end

  def execute(%User{} = user, %Place{} = place) do
    bonus_programs = active_bonus_programs(user)
    found = bonus_programs |> program_by(place)

    bonus_programs |> result(found)
  end

  defp active_bonus_programs(user) do
    from(
      bp in BonusProgram,
      where: bp.user_id == ^user.id and bp.state == "active"
    )
    |> Repo.all
  end

  defp program_by(bonus_programs, %Category{} = category) do
    bonus_programs
    |> Enum.filter(fn bp -> bp.category_id == category.id end)
    |> max
  end

  defp program_by(bonus_programs, %Place{} = place) do
    bonus_programs
    |> Enum.filter(
      fn bp ->
        (bp.place_id == place.id or bp.category_id == place.category_id)
      end
    )
    |> max
  end

  defp multipurpose(bonus_programs) do
    bonus_programs
    |> Enum.filter(fn bp -> bp.multipurpose end)
    |> max
  end

  defp max(bonus_programs) do
    bonus_programs
    |> Enum.max_by(fn bp -> bp.percentage end, fn -> nil end)
  end

  defp result(_, %BonusProgram{} = bonus_program) do
    {:ok, bonus_program}
  end

  defp result(nil, _bonus_program) do
    {:error, "not_found"}
  end

  defp result(bonus_programs, bonus_program) do
    found = bonus_programs |> multipurpose
    result(nil, found)
  end
end
