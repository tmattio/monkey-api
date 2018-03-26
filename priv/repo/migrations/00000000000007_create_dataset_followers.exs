defmodule Monkey.Repo.Migrations.CreateDatasetFollowers do
  use Ecto.Migration

  def change do
    create table(:dataset_followers, primary_key: false) do
      add(:user_id, references(:users, on_delete: :nothing), primary_key: true)
      add(:dataset_id, references(:datasets, on_delete: :delete_all), primary_key: true)

      timestamps()
    end

    create(unique_index(:dataset_followers, [:user_id, :dataset_id]))
  end
end
