defmodule WhatIsBetterToPay.Repo.Migrations.CreatePlaceLocations do
  use Ecto.Migration

  def up do
    create table(:place_locations) do
      add :place_id, references(:places)

      timestamps()
    end
    execute("""
      SELECT AddGeometryColumn (
        'place_locations','lng_lat_point',4326,'POINT',2
      );
      """)
    execute("""
      CREATE INDEX place_locations_gist_idx ON place_locations USING GIST(
        lng_lat_point
      )
      """)

    create index(:place_locations, :place_id)
  end

  def down do
    drop table(:place_locations)
    drop index(:place_locations, :place_id)
  end
end
