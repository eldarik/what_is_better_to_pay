defmodule WhatIsBetterToPay.Services.GoogleMaps.Test do
  @moduledoc false

  def place_nearby(_locaiton, _radius, _opts \\ []) do
    # NOTE: check google places api
    # there is only needed data for app,
    # other additional data can be fetched too
    {
      :ok,
      %{
        "results" => [
          %{
            "geometry" => %{
              "location" => %{"lat" => 55.78069199999999, "lng" => 49.213179}
            },
            "name" => "Koton",
            "types" => ~w/clothing_store point_of_interest store establishment/
          }
        ]
      }
    }
  end
end
