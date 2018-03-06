defmodule Monkey.Repo.Migrations.CreateDatasetFollowers do
  use Ecto.Migration

  def change do
    create table(:dataset_followers) do
      add(:user_id, references(:users, on_delete: :nothing))
      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(index(:dataset_followers, [:user_id]))
    create(index(:dataset_followers, [:dataset_id]))
  end
end
