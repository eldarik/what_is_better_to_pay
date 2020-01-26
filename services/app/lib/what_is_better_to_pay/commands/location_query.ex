defmodule WhatIsBetterToPay.Commands.LocationQuery do
  use WhatIsBetterToPay.Commander

  def execute(update) do
    send_message "Запрос по локации создан"
    # TODO:
    # 1. add calling Google Places API to detect place name and category
    # 2. find similar categories
    # 3. find bonus programs whit found place or categories
    # 4. send message with suggestion
  end
end
