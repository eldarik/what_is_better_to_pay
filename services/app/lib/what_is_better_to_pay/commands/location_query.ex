defmodule WhatIsBetterToPay.Commands.LocationQuery do
  use WhatIsBetterToPay.Commander

  def execute(%{message: %{location: _location}}= update) do
    send_message "Запрос по локации создан"
    # TODO:
    # {:ok, suggestion} =
    #   Map.merge(user_data(), %{location: location})
    #   |> Operations.ProcessLocationSuggestion.execute(user_data)
    # send_message suggestion
  end
end
