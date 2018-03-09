defmodule Monkey.Repo.Migrations.CreateDataImages do
  use Ecto.Migration

  def change do
    create table(:data_images) do
      add(:caption, :string)
      add(:storage_path, :string)
      add(:filesize, :integer)
      add(:width, :integer)
      add(:height, :integer)
      add(:depth, :integer)
      add(:compression_format, :string)

      timestamps()
    end

    create(unique_index(:data_images, [:storage_path]))
  end
end
