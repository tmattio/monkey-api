defmodule Monkey.Repo.Migrations.CreateLabelImageClasses do
  use Ecto.Migration

  def change do
    create table(:label_image_classes) do
      add(:class, :string)
      add(:dataset_id, references(:datasets, on_delete: :nothing))
      add(:datapoint_id, references(:data_images, on_delete: :nothing))

      timestamps()
    end

    create(index(:label_image_classes, [:dataset_id]))
    create(index(:label_image_classes, [:datapoint_id]))
  end
end
