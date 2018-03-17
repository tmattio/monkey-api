defmodule Monkey.Repo.Migrations.CreateDataTypes do
  use Ecto.Migration

  def change do
    create table(:data_types) do
      add(:name, :string)
    end

    create(unique_index(:data_types, [:name]))
  end
end
