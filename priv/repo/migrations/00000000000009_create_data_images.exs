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
      add(:dataset_id, references(:datasets, on_delete: :delete_all))

      timestamps()
    end

    create(unique_index(:data_images, [:storage_path]))
    create(index(:data_images, [:dataset_id]))
  end
end
