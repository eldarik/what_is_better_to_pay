defmodule WhatIsBetterToPay.Operations.ImportBonusPrograms do
  import Ecto.Query, only: [from: 2]
  alias WhatIsBetterToPay.{Repo, User, BonusProgram}
  alias WhatIsBetterToPay.Operations.CreateBonusProgram

  def execute(%{link: link} = params) do
    user = find_or_create_user(params)
    document_data = fetch_document(link)
    archive_previous_bonus_programs(user)
    create_new_bonus_programs(user, document_data)
    {:ok}
  end

  defp fetch_document(link) do
    google_docs_api = Application.get_env(:what_is_better_to_pay, :google_docs_api)
    {:ok, csv} = google_docs_api.fetch_document(link) |> StringIO.open
    csv
    |> IO.binstream(:line)
    |> CSV.Decoding.Decoder.decode
    |> Enum.map(fn parsed -> {:ok, row} = parsed; row end)
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

  defp archive_previous_bonus_programs(user) do
    from(
      bp in BonusProgram,
      where: bp.user_id == ^user.id and bp.state == "active"
    )
    |> Repo.all
    |> Enum.each(
      fn bonus_program ->
        bonus_program
        |> BonusProgram.changeset(%{state: "archived"})
        |> Repo.update()
      end
    )
  end

  defp create_new_bonus_programs(user, document_data) do
    # NOTE: first row with headers should be skipped
    document_data
    |> Enum.drop(1)
    |> Enum.each(fn row -> create_new_bonus_program(user, row) end)
  end

  defp create_new_bonus_program(user, row) do
    [card_title, percentage, category, place] = row
    CreateBonusProgram.execute(
      %{
        user: user,
        card_title: card_title,
        percentage: percentage,
        category: category,
        place: place
      }
    )
  end
end
