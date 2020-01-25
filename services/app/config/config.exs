use Mix.Config


config :what_is_better_to_pay,
  bot_name: System.get_env("TELEGRAM_BOT_NAME")

config :nadia,
  token: System.get_env("TELEGRAM_BOT_TOKEN")
