defmodule WhatIsBetterToPay.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :telegram_id, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :last_active_at, :naive_datetime
    end
  end
end
