defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByLocation do
  @moduledoc false
  @search_radius 50
  import WhatIsBetterToPay.Operations.ProcessSuggestion
  alias WhatIsBetterToPay.Operations.SaveGoogleMapsPlace
  alias WhatIsBetterToPay.Queries.PlacesGeoSearch

  def execute(%{location: location} = params) do
    place = geo_search(location)
    user = find_user(params)
    make_suggestion(user, place)
  end

  defp geo_search(%{latitude: lat, longitude: lng} = location) do
    places = PlacesGeoSearch.run({lat, lng})

    if Enum.empty?(places) do
      find_places_with_google_maps(location)
      |> save_places

      places = PlacesGeoSearch.run({lat, lng})
    end

    case places do
      [] ->
        nil

      _ ->
        [place | _] = places
        place
    end
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

    places_data["results"]
  end

  defp save_places(places) do
    places
    |> Enum.map(fn place_data -> SaveGoogleMapsPlace.execute(place_data) end)
  end

  defp make_suggestion(user, nil) when not is_nil(user) do
    {:error, "place_not_found"}
  end

  defp make_suggestion(user, place) do
    make_suggestion(user, nil, place)
  end
end
