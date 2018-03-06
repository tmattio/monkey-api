defmodule Monkey.Repo.Migrations.CreateLabelImageBoundingBoxes do
  use Ecto.Migration

  def change do
    create table(:label_image_bounding_boxes) do
      add(:x_min, :float)
      add(:x_max, :float)
      add(:y_min, :float)
      add(:y_max, :float)
      add(:class, :string)

      timestamps()
    end
  end
end
