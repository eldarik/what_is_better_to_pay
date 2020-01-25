defmodule WhatIsBetterToPay.Commands.Greetings do
  use WhatIsBetterToPay.Commander

  @import_document_example_url Application.get_env(
    :what_is_better_to_pay, :import_document_example_url
  )

  def hello(update) do
    # TODO: move to localized templates, find something like I18n in ruby
    send_message ~s/
      Здравствуйте, #{update.message.from.username}!
      Для того, чтобы начать пользоваться ботом ему необходимо сообщить
      данные о ваших категориях кэшбека:
      1. создайте таблицу по примеру - #{@import_document_example_url}
      2. заполните ваши категории
      3. отправьте в сообщении ссылку на документ
      4. в дальнейшем бот будет использовать эти данные
    /

    send_message ~s/
      Для того, чтобы узнать, чем лучше расплатиться, вы можете:
      1. отправить вашу геолокацию, бот найдет ближайшее место и посоветует вам чем лучше платить
      2. отправить сообщением категорию(кафе, ресторан, такси)
      или название места(MacDonalds, Starbucks), где вы совершаете покупку.
      Бот проанализирует эти данные и сообщит лучший вариант оплаты.
    /
  end
end
