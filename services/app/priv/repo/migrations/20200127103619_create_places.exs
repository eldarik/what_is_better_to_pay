defmodule WhatIsBetterToPay.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :title, :string, null: false
      add :category_id, references(:categories)

      timestamps()
    end

    create index(:places, :category_id)
    create unique_index(:places, :title)
  end
end
