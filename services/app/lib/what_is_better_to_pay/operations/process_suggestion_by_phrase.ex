defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByPhrase do
  alias WhatIsBetterToPay.{Place, Category}
  def execute(%{username: username, phrase: phrase} = params) do
    # TODO:
    # 1. try to find places, categories
    # 2. if something found call ProcessSuggestion
    # 3. unless something found on step 1 call google maps api to find place by name
    # 4. if place found on step 3 save it
    # 5. call ProcessSuggestion.execute(place)
    # 6. unless something found on step 3 call 3rd party api to get synonyms
    # 7. call ProcessSuggestion.execute(category)
    # 8. if nothing found on step 6 return {:error, nothing found}
  end
end
