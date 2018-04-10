defmodule Monkey.Repo.Migrations.CreateLabelImageBoundingBoxDefinitions do
  use Ecto.Migration

  def change do
    create table(:label_image_bounding_box_definitions) do
      add(:classes, {:array, :string})
      add(:label_type_id, references(:datasets, on_delete: :delete_all))
      add(:dataset_id, references(:datasets, on_delete: :delete_all))

      timestamps()
    end

    create(index(:label_image_bounding_box_definitions, [:label_type_id]))
    create(unique_index(:label_image_bounding_box_definitions, [:dataset_id]))
  end
end
