defmodule WhatIsBetterToPay.Operations.ImportBonusProgramsTest do
  use ExUnit.Case
  alias WhatIsBetterToPay.Operations.ImportBonusPrograms
  alias WhatIsBetterToPay.Repo
  alias WhatIsBetterToPay.User

  describe "#execute" do
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
end
