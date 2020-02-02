defmodule WhatIsBetterToPay.Commands.LocationQuery do
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Operations.ProcessSuggestionByLocation

  def execute(%{message: %{location: location}} = update) do
    send_message("Запрос по локации создан")

    params = Map.merge(user_data(), %{location: location})

    case ProcessSuggestionByLocation.execute(params) do
      {:ok, bonus_program} ->
        send_message(~s"""
        Лучший способ оплаты:
        #{bonus_program.card_title} c #{bonus_program.percentage}%
        """)

      _ ->
        send_message("К сожалению ничего не найдено, попробуйте уточнить ваш запрос")
    end
  end
end
