defmodule WhatIsBetterToPay.Commands.Greetings do
  use WhatIsBetterToPay.Commander

  def hello(update) do
    import_document_example_url =
      Application.get_env(:what_is_better_to_pay, :import_document_example_url)

    # TODO: move to localized templates, find something like I18n in ruby
    send_message("""
    Здравствуйте, #{update.message.from.username}!
    Для того, чтобы начать пользоваться ботом ему необходимо сообщить
    данные о ваших категориях кэшбека:
    1. создайте копию таблицы - #{import_document_example_url}
    2. заполните ваши категории
    3. дайте доступ по ссылке к созданной таблице
    4. отправьте в сообщении ссылку на документ
    5. в дальнейшем бот будет использовать эти данные
    """)

    send_message("""
    Для того, чтобы узнать, чем лучше расплатиться, вы можете:
    1. отправить вашу геолокацию, бот найдет ближайшее место и посоветует вам чем лучше платить
    2. отправить сообщением категорию(кафе, ресторан, такси)
    или название места(McDonalds, Starbucks), где вы совершаете покупку.
    Бот проанализирует эти данные и сообщит лучший вариант оплаты.
    """)
  end
end
