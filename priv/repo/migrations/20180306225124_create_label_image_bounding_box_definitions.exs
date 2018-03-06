defmodule Monkey.Repo.Migrations.CreateLabelImageBoundingBoxDefinitions do
  use Ecto.Migration

  def change do
    create table(:label_image_bounding_box_definitions) do
      add(:classes, {:array, :string})

      timestamps()
    end
  end
end
