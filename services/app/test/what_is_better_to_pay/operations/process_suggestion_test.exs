defmodule WhatIsBetterToPay.Operations.ProcessSuggestionTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.Operations.CreateBonusProgram
  alias WhatIsBetterToPay.{Repo, User, Category, Place, BonusProgram}
  alias WhatIsBetterToPay.Operations.ProcessSuggestion

  describe "execute" do
    test "returns bonus program with found category for user" do
      user = insert(:user)
      bonus_program_1 = insert(:bonus_program, user: user)
      bonus_program_2 = insert(:bonus_program, user: user)
      category = bonus_program_1.category
      {:ok, result} =
        ProcessSuggestion.execute(user, category)
      assert result.id == bonus_program_1.id
    end

    test "returns bonus program with found place for user" do
      user = insert(:user)
      bonus_program_1 = insert(:bonus_program, user: user)
      bonus_program_2 = insert(:bonus_program, user: user)
      place = bonus_program_1.place
      {:ok, result} =
        ProcessSuggestion.execute(user, place)
      assert result.id == bonus_program_1.id
    end

    test "returns multipurpose bonus program" do
      user = insert(:user)
      bonus_program_1 =
        insert(:bonus_program, user: user, multipurpose: true)
      bonus_program_2 = insert(:bonus_program, user: user)
      category = insert(:category)
      {:ok, result} =
        ProcessSuggestion.execute(user, category)
      assert result.id == bonus_program_1.id
    end
  end
end
