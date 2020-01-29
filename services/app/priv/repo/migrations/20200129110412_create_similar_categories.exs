defmodule WhatIsBetterToPay.Repo.Migrations.CreateSimilarCategories do
  use Ecto.Migration

  def change do
    create table(:similar_categories) do
      add :left_category_id, references(:categories)
      add :right_category_id, references(:categories)

      timestamps()
    end

    create index(:similar_categories, [:left_category_id, :right_category_id])
  end
end
