defmodule WhatIsBetterToPay.Commands do
  use WhatIsBetterToPay.Router
  use WhatIsBetterToPay.Commander

  # You can create commands in the format `/command` by
  # using the macro `command "command"`.
  command "start" do
    Logger.log :info, "Command /start"
    # Logger.log :info, Poison.encode! update.message
    send_message "Hello, " <> update.message.from.username
  end
end
