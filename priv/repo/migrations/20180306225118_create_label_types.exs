defmodule Monkey.Repo.Migrations.CreateLabelTypes do
  use Ecto.Migration

  def change do
    create table(:label_types) do
      add(:name, :string)
      add(:date_type_id, references(:data_types, on_delete: :nothing))

      timestamps()
    end

    create(index(:label_types, [:date_type_id]))
  end
end
