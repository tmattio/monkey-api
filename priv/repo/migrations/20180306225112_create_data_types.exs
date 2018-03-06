defmodule Monkey.Repo.Migrations.CreateDataTypes do
  use Ecto.Migration

  def change do
    create table(:data_types) do
      add(:name, :string)

      timestamps()
    end
  end
end
