defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByPhraseTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.Operations.ProcessSuggestionByPhrase

  describe "execute when user does not exist" do
    test "returns error" do
      username = "foobar"
      phrase = "foobar"
      result = ProcessSuggestionByPhrase.execute(%{username: username, phrase: phrase})

      assert result == {:error, "user_not_found"}
    end
  end
end
