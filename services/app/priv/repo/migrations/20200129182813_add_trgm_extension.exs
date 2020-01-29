defmodule WhatIsBetterToPay.Repo.Migrations.AddTrgmExtension do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION pg_trgm")
  end

  def down do
    execute("DROP EXTENSION pg_trgm")
  end
end
