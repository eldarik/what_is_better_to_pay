defmodule WhatIsBetterToPay.Operations.ProcessSuggestion do
  import Ecto.Query, only: [from: 2]
  alias WhatIsBetterToPay.{
    Repo, User, Place, Category, BonusProgram, SimilarCategory
  }

  def execute(%{user: user, category: category, place: place}) do
    bonus_programs = active_bonus_programs(user)
    all_categories = [category | similar_categories(category)]
    found_by_category = bonus_programs |> bonus_program_with(all_categories)
    found_by_place = bonus_programs |> bonus_program_with(place)
    found = compare(found_by_place, found_by_category)

    bonus_programs |> result(found)
  end

  defp active_bonus_programs(user) do
    from(
      bp in BonusProgram,
      where: bp.user_id == ^user.id and bp.state == "active"
    )
    |> Repo.all
  end

  defp bonus_program_with(bonus_programs, nil) do
    nil
  end

  defp bonus_program_with(bonus_programs, [nil]) do
    nil
  end

  defp bonus_program_with(bonus_programs, %Place{} = place) do
    bonus_programs \
    |> Enum.filter(
      fn bp ->
        (bp.place_id == place.id or bp.category_id == place.category_id)
      end
    ) \
    |> max
  end

  defp bonus_program_with(bonus_programs, categories) do
    bonus_program_with(bonus_programs, categories, nil)
  end

  defp bonus_program_with(bonus_programs, [category | categories], nil) do
    result =
      bonus_programs
      |> Enum.filter(fn bp -> bp.category_id == category.id end)
      |> max
    case result do
      nil ->
        bonus_programs |> bonus_program_with(categories)
      _ ->
        result
    end
  end

  defp bonus_program_with(bonus_programs, categories, bonus_program) do
    bonus_program
  end

  defp similar_categories(nil), do: []

  defp similar_categories(category) do
    from(
      c in Category,
      join: sc in SimilarCategory, on: sc.left_category_id == c.id,
      where: sc.right_category_id == ^category.id
    )
    |> Repo.all
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

  defp compare(%BonusProgram{} = left, %BonusProgram{} = right) do
    if(left.percentage > right.percentage, do: left, else: right)
  end

  defp compare(nil, %BonusProgram{} = bonus_program) do
    bonus_program
  end

  defp compare(%BonusProgram{} = bonus_program, nil) do
    bonus_program
  end

  defp compare(nil, nil) do
    nil
  end

  defp result(_, %BonusProgram{} = bonus_program) do
    {:ok, bonus_program}
  end

  defp result(nil, _bonus_program) do
    {:error, "not_found"}
  end

  defp result(bonus_programs, _bonus_program) do
    found = bonus_programs |> multipurpose
    result(nil, found)
  end
end
