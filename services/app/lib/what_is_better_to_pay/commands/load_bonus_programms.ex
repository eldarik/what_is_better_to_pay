defmodule WhatIsBetterToPay.Commands.LoadBonusPrograms do
  use WhatIsBetterToPay.Commander

  def execute(update) do
    # TODO:
    # 1. create user(username, first_name, last_name)
    # 2. download document from google docs
    # 3. load bonus programms from google docs
    # 4. send sucess message
    send_message "Документ обрабатывается..."
  end
end
