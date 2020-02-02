defmodule WhatIsBetterToPay.Operations.ProcessSuggestionByLocationTest do
  use WhatIsBetterToPay.RepoCase
  alias WhatIsBetterToPay.Operations.ProcessSuggestionByLocation
  import WhatIsBetterToPay.PlaceLocation, only: [build_lng_lat_point: 1]
  @location %{latitude: 55, longitude: 55}

  describe "execute when user does not exist" do
    test "returns error" do
      username = "foobar"
      result = ProcessSuggestionByLocation.execute(%{username: username, location: @location})

      assert result == {:error, "user_not_found"}
    end
  end

  describe "execute when place exists" do
    test "returns bonus program for user" do
      user = insert(:user)
      bonus_program = insert(:bonus_program, user: user)
      place = bonus_program.place
      %{latitude: lat, longitude: lng} = @location

      insert(
        :place_location,
        place: place,
        lng_lat_point: build_lng_lat_point({lng, lat})
      )

      bonus_program_2 = insert(:bonus_program, user: user)
      inspect(:place_location, place: bonus_program_2.place)

      {:ok, result} =
        ProcessSuggestionByLocation.execute(%{username: user.username, location: @location})

      assert bonus_program.id == result.id
    end
  end

  describe "execute when place does not exist" do
    test "returns bonus program for user" do
      user = insert(:user)

      result =
        ProcessSuggestionByLocation.execute(%{username: user.username, location: @location})

      require IEx
      IEx.pry()
      assert {:error, "place_not_found"} == result
    end
  end
end
