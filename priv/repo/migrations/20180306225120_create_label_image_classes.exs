defmodule Monkey.Repo.Migrations.CreateLabelImageClasses do
  use Ecto.Migration

  def change do
    create table(:label_image_classes) do
      add(:class, :string)

      timestamps()
    end
  end
end
