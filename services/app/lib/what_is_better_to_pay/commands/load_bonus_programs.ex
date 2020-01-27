defmodule WhatIsBetterToPay.Commands.LoadBonusPrograms do
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Operations.ImportBonusPrograms

  def execute(%{message: %{text: link}} = update) do
    send_message "Документ обрабатывается..."
    Map.merge(user_data, %{link: link})
    |> ImportBonusPrograms.execute
    send_message "Обработка завершена"
  end
end
