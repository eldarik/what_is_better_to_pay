defmodule WhatIsBetterToPay.Operations.ProcessSuggestionTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.Operations.CreateBonusProgram
  alias WhatIsBetterToPay.{Repo, User, Category, Place, BonusProgram}

  describe "execute" do
    test "returns bonus program with found category for user" do
      user = insert(:user)
      bonus_program = insert(:bonus_program, user: user)
      require IEx; IEx.pry
    end
  end
end
