defmodule Monkey.Repo.Migrations.CreateLabelAcls do
  use Ecto.Migration

  def change do
    create table(:label_acls) do
      add(:type_id, references(:label_types, on_delete: :nothing))
      add(:image_classification_id, references(:label_image_classes, on_delete: :nothing))
      add(:object_detection_id, references(:label_image_bounding_boxes, on_delete: :nothing))
      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(index(:label_acls, [:type_id]))
    create(index(:label_acls, [:image_classification_id]))
    create(index(:label_acls, [:object_detection_id]))
    create(index(:label_acls, [:dataset_id]))
  end
end
