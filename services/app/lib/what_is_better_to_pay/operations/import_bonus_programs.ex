defmodule WhatIsBetterToPay.Operations.ImportBonusPrograms do
  require Logger

  def execute(args) do
    %{
      username: username,
      first_name: first_name,
      last_name: last_name,
      link: link
    } = args

    # find_or_create_user
    document_data = fetch_document(link)
    Logger.log :info, "document data: #{document_data}"
    #
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
end
