# TODO:
# 1. add synonyms fetching for phrase, search APIs

defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByPhrase do
  import Ecto.Query, only: [from: 2]
  alias WhatIsBetterToPay.{Repo, User, Place, Category, Search}
  alias WhatIsBetterToPay.Operations.ProcessSuggestion

  def execute(%{phrase: phrase} = params) do
    category = find_category(phrase)
    place = find_place(phrase)
    user = find_user(params)
    make_suggestion(user, category, place)
  end

  defp find_user(%{username: username}) do
    User |> Repo.get_by(username: username)
  end

  defp find_user(%{telegram_id: telegram_id}) do
    User |> Repo.get_by(telegram_id: telegram_id)
  end

  defp find_category(phrase) do
    from(category in Category, limit: 1)
    |> Search.run(phrase)
    |> Repo.one()
  end

  defp find_place(phrase) do
    from(place in Place, limit: 1)
    |> Search.run(phrase)
    |> Repo.one()
  end

  defp make_suggestion(nil, _, _) do
    {:error, "user_not_found"}
  end

  defp make_suggestion(user, category, place) do
    ProcessSuggestion.execute(%{user: user, category: category, place: place})
  end
end
