defmodule Monkey.Repo.Migrations.CreateDataAcls do
  use Ecto.Migration

  def change do
    create table(:data_acls) do
      add(:data_type_id, references(:data_types, on_delete: :nothing))
      add(:image_id, references(:data_images, on_delete: :nothing))
      add(:video_id, references(:data_videos, on_delete: :nothing))
      add(:text_id, references(:data_texts, on_delete: :nothing))
      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(index(:data_acls, [:data_type_id]))
    create(unique_index(:data_acls, [:image_id]))
    create(unique_index(:data_acls, [:video_id]))
    create(unique_index(:data_acls, [:text_id]))
    create(unique_index(:data_acls, [:dataset_id]))
  end
end
