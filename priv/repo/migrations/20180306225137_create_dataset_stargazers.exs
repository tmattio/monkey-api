defmodule Monkey.Repo.Migrations.CreateDatasetStargazers do
  use Ecto.Migration

  def change do
    create table(:dataset_stargazers) do
      add(:user_id, references(:users, on_delete: :nothing))
      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(index(:dataset_stargazers, [:user_id]))
    create(index(:dataset_stargazers, [:dataset_id]))
  end
end
