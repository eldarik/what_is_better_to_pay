defmodule WhatIsBetterToPay.Operations.CreateBonusProgramTest do
  use WhatIsBetterToPay.RepoCase
  import Map, only: [merge: 2]
  alias WhatIsBetterToPay.Operations.CreateBonusProgram
  alias WhatIsBetterToPay.{Repo, BonusProgram}

  describe "execute" do
    @params %{
      card_title: "card 123",
      percentage: "5",
      category: "category",
      place: "place"
    }

    test "creates bonus program" do
      user = insert(:user)
      result =
        merge(@params, %{user: user})
        |> CreateBonusProgram.execute
      assert result == {:ok}
      bonus_program = BonusProgram |> Repo.get_by(user_id: user.id)
      refute bonus_program == nil
      refute bonus_program.category_id == nil
      refute bonus_program.place_id == nil
    end
  end

  describe "execute when multipurpose bonus program" do
    @params %{
      card_title: "card 123",
      percentage: "5",
      category: "*",
      place: "place"
    }

    test "creates multipurpose bonus program" do
      user = insert(:user)
      result =
        merge(@params, %{user: user})
        |> CreateBonusProgram.execute
      assert result == {:ok}
      bonus_program = BonusProgram |> Repo.get_by(user_id: user.id)
      refute bonus_program == nil
      assert bonus_program.multipurpose == true
      assert bonus_program.category_id == nil
      assert bonus_program.place_id == nil
    end
  end

  describe "execute when place is - (not filled)" do
     @params %{
      card_title: "card 123",
      percentage: "5",
      place: "-"
    }

    test "creates bonus program" do
      user = insert(:user)
      category = insert(:category)
      similar_category = insert(:category)
      insert(
        :similar_category,
        left_category: category,
        right_category: similar_category
      )
      result =
        merge(@params, %{user: user, category: category.title})
        |> CreateBonusProgram.execute
      assert result == {:ok}
      bonus_program = BonusProgram |> Repo.get_by(user_id: user.id)
      refute bonus_program == nil
      assert bonus_program.multipurpose == false
      refute bonus_program.category_id == nil
      assert bonus_program.place_id == nil
    end
  end
end
