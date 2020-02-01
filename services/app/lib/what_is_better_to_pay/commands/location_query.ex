defmodule WhatIsBetterToPay.Commands.LocationQuery do
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Operations.ProcessSuggestionByLocation

  def execute(%{message: %{location: location}} = update) do
    send_message("Запрос по локации создан")

    Map.merge(user_data(), %{location: location})
    |> ProcessSuggestionByLocation.execute()

    # TODO:
    # {:ok, suggestion} =
    #   Map.merge(user_data(), %{location: location})
    #   |> Operations.ProcessLocationSuggestion.execute(user_data)
    # send_message suggestion
  end
end
