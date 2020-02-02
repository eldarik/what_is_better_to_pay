defmodule WhatIsBetterToPay.Queries.PlacesGeoSearch do
  @moduledoc false

  import Ecto.Adapters.SQL, only: [query!: 3]
  alias WhatIsBetterToPay.{Repo, Place}

  def run({lat, lng}) do
    result =
      Repo
      |> query!(
        """
        SELECT places.id,
               title,
               category_id
        FROM places
        JOIN place_locations on place_locations.place_id = places.id
        WHERE
          ST_DWithin(
            lng_lat_point,
            ST_GeomFromEWKT('SRID=4326;POINT(#{lng} #{lat})'),
            0.003
          )
        ORDER BY
          lng_lat_point <-> ST_GeomFromEWKT('SRID=4326;POINT(#{lng} #{lat})')
        LIMIT 10
        """,
        []
      )

    Enum.map(result.rows, &Repo.load(Place, {result.columns, &1}))
    # TODO: find out why sql generated
    # by ecto returns rows in wrong order
    # from(
    #   place in Place,
    #   right_join: place_location in PlaceLocation,
    #   on: place.id == place_location.place_id,
    #   order_by: fragment(
    #     "?",
    #     ^"lng_lat_point <-> ST_GeomFromEWKT('SRID=4326;POINT(#{lng} #{lat})')"
    #   )
    # )
  end
end
