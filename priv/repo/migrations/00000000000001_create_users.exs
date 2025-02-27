defmodule Monkey.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string)
      add(:password_hash, :string)
      add(:username, :string)
      add(:name, :string)
      add(:bio, :string)
      add(:avatar_url, :string)
      add(:website_url, :string)
      add(:company, :string)
      add(:last_login, :naive_datetime)
      add(:is_active, :boolean, default: false, null: false)
      add(:organization_id, references(:organizations, on_delete: :nothing))

      timestamps()
    end

    create(index(:users, [:organization_id]))

    create(unique_index(:users, [:username]))
    create(unique_index(:users, [:email]))
  end
end
