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

      timestamps()
    end
  end
end
