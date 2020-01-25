defmodule WhatIsBetterToPay.Services.GoogleDocs do
  require HTTPoison
  require Logger
  @document_id_regex ~r/https:\/\/docs.google.com\/spreadsheets\/d\/(.*)\/.*/

  def fetch_document(link) do
    response =
      parse_document_id(link)
      |> wrap_for_download
      |> HTTPoison.get

    case response do
      {:ok, %HTTPoison.Response{body: body}} ->
        body
      _ ->
        Logger.log :warn, "Raised error while fetching document: #{link}"
    end
  end

  defp parse_document_id(link) do
    [_, id] = Regex.run(@document_id_regex, link)

    id
  end

  defp wrap_for_download(id) do
    "https://docs.google.com/spreadsheets/d/#{id}/export?format=csv"
  end
end
