defmodule WhatIsBetterToPay.Commands.LoadBonusPrograms do
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Operations.ImportBonusPrograms

  def execute(update) do
    send_message "Документ обрабатывается..."
    %{
      message: %{
        text: link,
        from: %{
          username: username,
          first_name: first_name,
          last_name: last_name,
          id: telegram_id
        }
      }
    } = update
    ImportBonusPrograms.execute(
      %{
        link: link,
        username: username,
        first_name: first_name,
        last_name: last_name,
        telegram_id: telegram_id |> Integer.to_string
      }
    )
    send_message "Обработка завершена"
  end
end
