defmodule WhatIsBetterToPay do
  @moduledoc """
  Documentation for WhatIsBetterToPay.
  """

  use Application

  def start(_type, _args) do
    bot_name = Application.get_env(:what_is_better_to_pay, :bot_name)
    token = Application.get_env(:nadia, :token)

    IO.warn """
    TELEGRAM_BOT_TOKEN
    #{token}
    """
    unless String.valid?(bot_name) do
      IO.warn """
      Env not found Application.get_env(:what_is_better_to_pay, :bot_name)
      This will give issues when generating commands
      """
    end

    if bot_name == "" do
      IO.warn "An empty bot_name env will make '/anycommand@' valid"
    end

    import Supervisor.Spec, warn: false

    children = [
      supervisor(WhatIsBetterToPay.Poller, []),
      supervisor(WhatIsBetterToPay.Matcher, []),
      supervisor(WhatIsBetterToPay.Repo, [])
    ]

    opts = [
      strategy: :one_for_one,
      name: WhatIsBetterToPay.Supervisor
    ]
    Supervisor.start_link(children, opts)
  end

end
