defmodule WhatIsBetterToPay.Commands do
  use WhatIsBetterToPay.Router
  use WhatIsBetterToPay.Commander
  alias WhatIsBetterToPay.Commands.{
    Greetings, LocationQuery, LoadBonusPrograms, PhraseQuery
  }
  alias WhatIsBetterToPay.Services.GoogleDocs

  command "start", Greetings, :hello

  location_query LocationQuery, :execute

  message do
    cond do
      GoogleDocs.valid_link?(update.message.text) ->
        LoadBonusPrograms.execute(update)
      true ->
        PhraseQuery.execute(update)
        # Logger.log :warn, "Did not match the message"
        # Logger.log :info, "#{Jason.encode! update.message}"
        # send_message "Sorry, I couldn't understand you"
    end
  end
end
