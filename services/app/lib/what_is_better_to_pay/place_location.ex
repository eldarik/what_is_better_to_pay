defmodule WhatIsBetterToPay.PlaceLocation do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "place_locations" do
    field(:lng_lat_point, Geo.PostGIS.Geometry)

    timestamps()

    belongs_to(:place, WhatIsBetterToPay.Place)
  end

  def changeset(struct, params \\ %{}) do
    lng_lat_point = build_lng_lat_point(params[:lng_lat_point])
    params = Map.merge(params, %{lng_lat_point: lng_lat_point})

    struct
    |> cast(
      params,
      [:lng_lat_point, :place_id]
    )
    |> validate_required([:lng_lat_point, :place_id])
  end

  def settings_changeset(object, params \\ %{}) do
    lng_lat_point = build_lng_lat_point(params[:lng_lat_point])
    params = Map.merge(params, %{lng_lat_point: lng_lat_point})

    object
    |> cast(
      params,
      [:lng_lat_point, :place_id],
      []
    )
  end

  def build_lng_lat_point({longitude, latitude}) do
    %Geo.Point{coordinates: {longitude, latitude}, srid: 4326}
  end
end
