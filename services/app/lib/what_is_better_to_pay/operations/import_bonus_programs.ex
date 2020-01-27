defmodule WhatIsBetterToPay.Operations.ImportBonusPrograms do
  require Logger
  alias WhatIsBetterToPay.{Repo, User}

  def execute(params) do
    %{link: link} = params

    user = find_or_create_user(params)
    document_data = fetch_document(link)
    # archive_previous_programs
    # create_new_programs
    {:ok}
  end

  defp google_docs_api do
    Application.get_env(:what_is_better_to_pay, :google_docs_api)
  end

  defp fetch_document(link) do
    Logger.log :info, google_docs_api
    google_docs_api.fetch_document(link)
  end

  defp find_or_create_user(%{telegram_id: telegram_id} = params) do
    user = User |> Repo.get_by(telegram_id: telegram_id)
    case user do
      nil ->
        {:ok, user} = create_user(params)
        user
      _ ->
        user
    end
  end

  defp create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end
end
