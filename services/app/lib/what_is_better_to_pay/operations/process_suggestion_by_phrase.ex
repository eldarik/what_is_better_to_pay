# TODO:
# 1. add synonyms fetching for phrase, search APIs

defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByPhrase do
  import WhatIsBetterToPay.Operations.ProcessSuggestion
  import Ecto.Query, only: [from: 2]
  alias WhatIsBetterToPay.{Repo, Place, Category}
  alias WhatIsBetterToPay.Queries.FulltextSearch

  def execute(%{phrase: phrase} = params) do
    category = find_category(phrase)
    place = find_place(phrase)
    user = find_user(params)
    make_suggestion(user, category, place)
  end

  defp find_category(phrase) do
    from(category in Category, limit: 1)
    |> FulltextSearch.run(phrase)
    |> Repo.one()
  end

  defp find_place(phrase) do
    from(place in Place, limit: 1)
    |> FulltextSearch.run(phrase)
    |> Repo.one()
  end
end
