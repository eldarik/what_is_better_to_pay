defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByLocation do
  @moduledoc false
  @search_radius 50
  alias WhatIsBetterToPay.Operations.SaveGoogleMapsPlace

  def execute(%{username: username, location: location}) do
    find_places_with_google_maps(location)
    |> save_places

    # TODO:
    # 1. try to find nearest place by postgis in local db
    # 2. unless place was found  call google maps api to detect nearest place
    # 3. save found place, place location on step 2
    # 4. call ProcessSuggestion.execute(place)
  end

  defp find_places_with_google_maps(%{longitude: longitude, latitude: latitude}) do
    google_maps_api = Application.get_env(:what_is_better_to_pay, :google_maps_api)

    {:ok, places_data} =
      "#{latitude},#{longitude}"
      |> google_maps_api.place_nearby(
        @search_radius,
        language: "ru",
        rankby: "distance"
      )

    require IEx
    IEx.pry()
    places_data["results"]
  end

  def save_places(places) do
    places
    |> Enum.map(fn place_data -> SaveGoogleMapsPlace.execute(place_data) end)
  end

  def find_places(%{longitude: longitude, latitude: latitude}) do
  end
end
