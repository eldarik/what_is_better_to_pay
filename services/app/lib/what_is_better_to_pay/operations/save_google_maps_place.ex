defmodule WhatIsBetterToPay.Operations.SaveGoogleMapsPlace do
  @moduledoc false
  @google_maps_place_types_data_path "lib/static_data/google_maps_place_types.yml"

  alias WhatIsBetterToPay.{
    Repo,
    Category,
    Place,
    PlaceLocation
  }

  def execute(%{
        "geometry" => %{"location" => location},
        "name" => title,
        "types" => place_types
      }) do
    category = find_or_create_category(place_types)
    place = find_or_create_place(title, category)
    place |> save_location(location)

    case place do
      nil -> {:error, "place is not saved"}
      _ -> {:ok, place}
    end
  end

  defp find_or_create_category(place_types) when is_list(place_types) do
    {:ok, google_maps_place_types} = google_maps_place_types()
    types = Map.keys(google_maps_place_types)

    place_type =
      place_types
      |> Enum.find(fn place_type -> place_type in types end)

    google_maps_place_types[place_type]
    |> find_or_create_category
  end

  defp find_or_create_category(title) when is_nil(title) do
    nil
  end

  defp find_or_create_category(title) when is_binary(title) do
    category = Category |> Repo.get_by(title: title)

    case category do
      nil ->
        {:ok, category} =
          %Category{}
          |> Category.changeset(%{title: title})
          |> Repo.insert()

        category

      _ ->
        category
    end
  end

  defp find_or_create_place(_, nil) do
    nil
  end

  defp find_or_create_place(title, category) do
    place = Place |> Repo.get_by(category_id: category.id, title: title)

    case place do
      nil ->
        {:ok, place} =
          %Place{}
          |> Place.changeset(%{title: title, category_id: category.id})
          |> Repo.insert()

        place

      _ ->
        place
    end
  end

  defp save_location(nil, location) do
    nil
  end

  defp save_location(place, %{"lat" => lat, "lng" => lng}) do
    params = %{place_id: place.id, lng_lat_point: {lng, lat}}

    %PlaceLocation{}
    |> PlaceLocation.changeset(params)
    |> Repo.insert()
  end

  defp google_maps_place_types do
    File.cwd!()
    |> Path.join(@google_maps_place_types_data_path)
    |> YamlElixir.read_from_file()
  end
end
