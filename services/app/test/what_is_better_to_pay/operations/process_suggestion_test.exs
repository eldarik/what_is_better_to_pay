defmodule WhatIsBetterToPay.Operations.ProcessSuggestionTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.Operations.CreateBonusProgram
  alias WhatIsBetterToPay.{Repo, User, Category, Place, BonusProgram}
  alias WhatIsBetterToPay.Operations.ProcessSuggestion

  describe "execute when passed category" do
    test "returns bonus program for user" do
      user = insert(:user)
      bonus_program_1 = insert(:bonus_program, user: user)
      bonus_program_2 = insert(:bonus_program, user: user)
      category = bonus_program_1.category
      {:ok, result} =
        ProcessSuggestion.execute(%{user: user, category: category})
      assert result.id == bonus_program_1.id
    end
  end

  describe "execute when pacced category not found" do
    test "returns multipurpose bonus program" do
      user = insert(:user)
      bonus_program_1 =
        insert(:bonus_program, user: user, multipurpose: true)
      bonus_program_2 = insert(:bonus_program, user: user)
      category = insert(:category)
      {:ok, result} =
        ProcessSuggestion.execute(%{user: user, category: category})
      assert result.id == bonus_program_1.id
    end
  end

  describe "execute  when passed place" do
    test "returns bonus program for user" do
      user = insert(:user)
      bonus_program_1 = insert(:bonus_program, user: user)
      bonus_program_2 = insert(:bonus_program, user: user)
      place = bonus_program_1.place
      {:ok, result} =
        ProcessSuggestion.execute(%{user: user, place: place})
      assert result.id == bonus_program_1.id
    end
  end

  describe "execute  when passed place and category" do
    test "returns best bonus program for user" do
      user = insert(:user)
      bonus_program_1 =
        insert(:bonus_program, user: user, percentage: 10)
      bonus_program_2 =
        insert(:bonus_program, user: user, percentage: 5)
      place = bonus_program_1.place
      category = bonus_program_2.category
      {:ok, result} =
        ProcessSuggestion.execute(
          %{user: user, place: place, category: category}
        )
      assert result.id == bonus_program_1.id
    end

    test "when bonus program with category does not exist" do
      user = insert(:user)
      bonus_program_1 =
        insert(:bonus_program, user: user, percentage: 10)
      bonus_program_2 =
        insert(:bonus_program, user: user, percentage: 5)
      place = insert(:place)
      category = bonus_program_2.category
      {:ok, result} =
        ProcessSuggestion.execute(
          %{user: user, place: place, category: category}
        )
      assert result.id == bonus_program_2.id
    end

    test "when bonus program with place does not exist" do
      user = insert(:user)
      bonus_program_1 =
        insert(:bonus_program, user: user, percentage: 10)
      bonus_program_2 =
        insert(:bonus_program, user: user, percentage: 5)
      place = bonus_program_1.place
      category = insert(:category)
      {:ok, result} =
        ProcessSuggestion.execute(
          %{user: user, place: place, category: category}
        )
      assert result.id == bonus_program_1.id
    end
  end
end
