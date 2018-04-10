defmodule Monkey.Repo.Migrations.CreateDatasetStargazers do
  use Ecto.Migration

  def change do
    create table(:dataset_stargazers, primary_key: false) do
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      add(:dataset_id, references(:datasets, on_delete: :delete_all), primary_key: true)

      timestamps(updated_at: false)
    end

    create(unique_index(:dataset_stargazers, [:user_id, :dataset_id]))
  end
end
