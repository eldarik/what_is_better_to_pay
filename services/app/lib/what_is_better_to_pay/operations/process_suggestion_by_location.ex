defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByLocation do
  def execute(%{username: username, location: location} = params) do
    # TODO:
    # 1. try to find nearest place by postgis in local db
    # 2. unless place was found  call google maps api to detect nearest place
    # 3. save found place, place location on step 2
    # 4. call ProcessSuggestion.execute(place)
  end
end
