defmodule Monkey.Repo.Migrations.CreateLabelDefinitionsAcls do
  use Ecto.Migration

  def change do
    create table(:label_definitions_acls) do
      add(:data_type_id, references(:label_types, on_delete: :nothing))

      add(
        :image_classification_id,
        references(:label_image_class_definitions, on_delete: :nothing)
      )

      add(
        :image_bounding_box_id,
        references(:label_image_bounding_box_definitions, on_delete: :nothing)
      )

      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(index(:label_definitions_acls, [:data_type_id]))
    create(unique_index(:label_definitions_acls, [:image_classification_id]))
    create(unique_index(:label_definitions_acls, [:image_bounding_box_id]))
    create(unique_index(:label_definitions_acls, [:dataset_id]))
  end
end
