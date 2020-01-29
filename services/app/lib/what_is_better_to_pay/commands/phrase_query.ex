defmodule WhatIsBetterToPay.Commands.PhraseQuery do
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Operations.ProcessSuggestionByPhrase

  def execute(%{message: %{text: phrase}} = update) do
    params = user_data |> Map.merge(%{phrase: phrase})
    case params |> ProcessSuggestionByPhrase.execute do
      {:ok, bonus_program} ->
        send_message ~s"""
          Лучший способ оплаты:
          #{bonus_program.card_title} c #{bonus_program.percentage}%
          """
      _ ->
        send_message "К сожалению ничего не найдено, попробуйте уточнить ваш запрос"
    end
  end
end
