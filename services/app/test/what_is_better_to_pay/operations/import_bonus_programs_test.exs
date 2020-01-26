defmodule WhatIsBetterToPay.Operations.ImportBonusProgramsTest do
  use ExUnit.Case
  alias WhatIsBetterToPay.Operations.ImportBonusPrograms

  describe "#execute" do
    @args %{
      username: "foobar",
      first_name: "Foo",
      last_name: "Bar",
      link: "foobar-link"
    }

    test "creates user, save bonus programs from document" do
      assert ImportBonusPrograms.execute(@args) == {:ok}
    end
  end
end
