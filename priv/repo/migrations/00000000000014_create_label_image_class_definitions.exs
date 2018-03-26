defmodule Monkey.Repo.Migrations.CreateLabelImageClassDefinitions do
  use Ecto.Migration

  def change do
    create table(:label_image_class_definitions) do
      add(:classes, {:array, :string})
      add(:label_type_id, references(:datasets, on_delete: :nothing))
      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(index(:label_image_class_definitions, [:label_type_id]))
    create(unique_index(:label_image_class_definitions, [:dataset_id]))
  end
end
