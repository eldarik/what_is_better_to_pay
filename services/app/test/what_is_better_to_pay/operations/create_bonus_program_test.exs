defmodule WhatIsBetterToPay.Operations.CreateBonusProgramTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.Operations.CreateBonusProgram
  alias WhatIsBetterToPay.{Repo, User, BonusProgram}

  @user_params %{username: "foobar", telegram_id: "foobar123"}

  %User{}
  |> User.changeset(@user_params)
  |> Repo.insert()

  describe "execute" do
    @params %{
      card_title: "card 123",
      percentage: "5",
      category: "category",
      place: "place"
    }

    test "creates bonus program" do
      user = User |> Repo.get_by(@user_params)
      result =
        Map.merge(@params, %{user: user})
        |> CreateBonusProgram.execute
      assert result == {:ok}
      bonus_program = BonusProgram |> Repo.get_by(user_id: user.id)
      refute bonus_program == nil
    end
  end

  describe "execute when multipurpose bonus program" do
    @params %{
      card_title: "card 123",
      percentage: "5",
      category: "*",
      place: "place"
    }

    test "creates bonus program" do
      user = User |> Repo.get_by(@user_params)
      result =
        Map.merge(@params, %{user: user})
        |> CreateBonusProgram.execute
      assert result == {:ok}
      bonus_program = BonusProgram |> Repo.get_by(user_id: user.id)
      refute bonus_program == nil
      assert bonus_program.multipurpose == true
    end
  end
end
