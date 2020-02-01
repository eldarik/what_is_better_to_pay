defmodule WhatIsBetterToPay.Commands.LoadBonusPrograms do
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Operations.ImportBonusPrograms

  def execute(%{message: %{text: link}} = update) do
    send_message("Документ обрабатывается...")

    user_data()
    |> Map.merge(%{link: link})
    |> ImportBonusPrograms.execute()

    send_message("Обработка завершена")
  end
end
