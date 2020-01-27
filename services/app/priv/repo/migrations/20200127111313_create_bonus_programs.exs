defmodule WhatIsBetterToPay.Repo.Migrations.CreateBonusPrograms do
  use Ecto.Migration

  def change do
    create table(:bonus_programs) do
      add :card_title, :string, null: false
      add :percentage, :decimal, null: false
      add :multipurpose, :bool, null: false
      add :state, :string, null: false

      add :user_id, references(:users)
      add :category_id, references(:categories)
      add :place_id, references(:places)

      timestamps()
    end

    create index(:bonus_programs, :user_id)
    create index(:bonus_programs, :category_id)
    create index(:bonus_programs, :place_id)
  end
end
