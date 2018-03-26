defmodule Monkey.Repo.Migrations.CreateLabelImageBoundingBoxes do
  use Ecto.Migration

  def change do
    create table(:label_image_bounding_boxes) do
      add(:x_min, :float)
      add(:x_max, :float)
      add(:y_min, :float)
      add(:y_max, :float)
      add(:class, :string)
      add(:dataset_id, references(:datasets, on_delete: :nothing))
      add(:datapoint_id, references(:data_images, on_delete: :nothing))

      timestamps()
    end

    create(index(:label_image_bounding_boxes, [:dataset_id]))
    create(index(:label_image_bounding_boxes, [:datapoint_id]))
  end
end
