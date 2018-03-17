defmodule Monkey.Repo.Migrations.CreateLabelAcls do
  use Ecto.Migration

  def change do
    create table(:label_acls) do
      add(:label_type_id, references(:label_types, on_delete: :nothing))
      add(:image_class_id, references(:label_image_classes, on_delete: :nothing))
      add(:image_bounding_box_id, references(:label_image_bounding_boxes, on_delete: :nothing))
      add(:dataset_id, references(:datasets, on_delete: :nothing))
    end

    create(index(:label_acls, [:label_type_id]))
    create(index(:label_acls, [:dataset_id]))
    create(unique_index(:label_acls, [:image_class_id]))
    create(unique_index(:label_acls, [:image_bounding_box_id]))
  end
end
