defmodule Monkey.Repo.Migrations.CreateUserFollowers do
  use Ecto.Migration

  def change do
    create table(:user_followers) do
      add(:user_id, references(:users, on_delete: :nothing))
      add(:followee_id, references(:users, on_delete: :nothing))

      timestamps()
    end

    create(index(:user_followers, [:user_id]))
    create(index(:user_followers, [:followee_id]))
  end
end
