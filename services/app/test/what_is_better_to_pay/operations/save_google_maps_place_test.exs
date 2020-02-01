defmodule WhatIsBetterToPay.Operations.SaveGoogleMapsPlaceTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.{Repo, PlaceLocation}
  alias WhatIsBetterToPay.Operations.SaveGoogleMapsPlace

  describe "execute" do
    @params %{
      "name" => "foobar",
      "geometry" => %{
        "location" => %{
          "lat" => 55.8268342,
          "lng" => 49.20204529999999
        }
      },
      "types" => ~w/cafe/
    }

    test "saves google maps place's data" do
      {:ok, place} = SaveGoogleMapsPlace.execute(@params)
      refute place == nil
      refute place.category_id == nil
      place_location = PlaceLocation |> Repo.get_by(place_id: place.id)
      refute place_location == nil
    end
  end

  describe "execute when types does not include real place category" do
    @params %{
      "name" => "foobar",
      "geometry" => %{
        "location" => %{
          "lat" => 55.8268342,
          "lng" => 49.20204529999999
        }
      },
      "types" => ~w/point_of_interest establishment/
    }

    test "returns error" do
      result = SaveGoogleMapsPlace.execute(@params)
      assert {:error, "place is not saved"} == result
    end
  end
end
