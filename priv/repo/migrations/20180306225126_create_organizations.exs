defmodule Monkey.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add(:avatar_url, :string)
      add(:description, :string)
      add(:email, :string)
      add(:billing_email, :string)
      add(:name, :string)
      add(:website_url, :string)
      add(:is_active, :boolean, default: false, null: false)

      timestamps()
    end
  end
end
