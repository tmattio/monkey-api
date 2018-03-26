defmodule Monkey.Repo.Migrations.CreateLabelTypes do
  use Ecto.Migration

  def change do
    create table(:label_types) do
      add(:name, :string)
      add(:data_type_id, references(:data_types, on_delete: :nothing))
    end

    create(index(:label_types, [:data_type_id]))
    create(unique_index(:label_types, [:name]))
  end
end
