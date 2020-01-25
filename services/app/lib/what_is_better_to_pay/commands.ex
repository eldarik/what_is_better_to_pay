defmodule WhatIsBetterToPay.Commands do
  use WhatIsBetterToPay.Router
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Commands.Greetings

  # You can create commands in the format `/command` by
  # using the macro `command "command"`.
  #
  command "start", Greetings, :hello
end
