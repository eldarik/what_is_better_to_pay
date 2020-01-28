defmodule WhatIsBetterToPay.Operations.ImportBonusProgramsTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.Operations.ImportBonusPrograms
  alias WhatIsBetterToPay.Repo
  alias WhatIsBetterToPay.User

  describe "execute" do
    @params %{
      username: "foobar",
      first_name: "Foo",
      last_name: "Bar",
      telegram_id: "foobar123",
      link: "foobar-link"
    }

    test "creates user, save bonus programs from document" do
      assert ImportBonusPrograms.execute(@params) == {:ok}
      user = User |> Repo.get_by(telegram_id: @params[:telegram_id])
      refute user == nil
    end
  end

  describe "execute for existing user" do
    @params %{link: "foobar-link"}

    test "creates user, save bonus programs from document" do
      user = insert(:user)
      result =
        Map.merge(@params, %{telegram_id: user.telegram_id})
        |> ImportBonusPrograms.execute
      assert result == {:ok}
    end
  end
end
