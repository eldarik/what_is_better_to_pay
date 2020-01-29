defmodule WhatIsBetterToPay.Repo.Migrations.AddTrgmIndexes do
  use Ecto.Migration

  def up do
    execute("""
      CREATE INDEX categories_trgm_idx ON categories USING GIN (
        to_tsvector('russian', title)
      )
      """)
  end

  def down do
    execute("Drop INDEX categories_trgm_idx ON categories")
  end
end
