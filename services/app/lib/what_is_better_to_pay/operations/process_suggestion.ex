defmodule WhatIsBetterToPay.Operations.ProcessSuggestion do
  @moduledoc false
  alias WhatIsBetterToPay.{Repo, User}
  alias WhatIsBetterToPay.Operations.MakeSuggestion

  def find_user(%{username: username}) do
    User |> Repo.get_by(username: username)
  end

  def find_user(%{telegram_id: telegram_id}) do
    User |> Repo.get_by(telegram_id: telegram_id)
  end

  def make_suggestion(nil, _, _) do
    {:error, "user_not_found"}
  end

  def make_suggestion(user, category, place) do
    MakeSuggestion.execute(%{user: user, category: category, place: place})
  end
end
