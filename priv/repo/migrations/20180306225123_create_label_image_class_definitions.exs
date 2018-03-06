defmodule Monkey.Repo.Migrations.CreateLabelImageClassDefinitions do
  use Ecto.Migration

  def change do
    create table(:label_image_class_definitions) do
      add(:classes, {:array, :string})

      timestamps()
    end
  end
end
