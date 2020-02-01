defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByLocation do
  @moduledoc false
  @search_radius 50

  def execute(%{username: _username, location: location} = _params) do
    # TODO:
    # 1. try to find nearest place by postgis in local db
    # 2. unless place was found  call google maps api to detect nearest place
    # 3. save found place, place location on step 2
    # 4. call ProcessSuggestion.execute(place)
  end

  defp find_places(location) do
    google_maps_api = Application.get_env(:what_is_better_to_pay, :google_maps_api)
    {:ok, places_data} =
      location
      |> google_maps_api.place_nearby(
           @search_radius, %{language: "ru", rankby: "distance"}
         )

    places_data["results"]
  end
end
