defmodule Monkey.Repo.Migrations.CreateDataVideos do
  use Ecto.Migration

  def change do
    create table(:data_videos) do
      add(:caption, :string)
      add(:storage_path, :string)
      add(:width, :integer)
      add(:height, :integer)
      add(:depth, :integer)
      add(:compression_format, :string)
      add(:duration, :integer)
      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(unique_index(:data_videos, [:storage_path]))
    create(index(:data_videos, [:dataset_id]))
  end
end
