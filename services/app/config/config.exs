use Mix.Config


config :what_is_better_to_pay,
  bot_name: System.get_env("TELEGRAM_BOT_NAME"),
  import_document_example_url: System.get_env("IMPORT_DOCUMENT_EXAMPLE_URL")

config :nadia,
  token: System.get_env("TELEGRAM_BOT_TOKEN")
