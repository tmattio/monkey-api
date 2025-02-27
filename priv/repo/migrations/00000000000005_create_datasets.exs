defmodule Monkey.Repo.Migrations.CreateDatasets do
  use Ecto.Migration

  def change do
    create table(:datasets) do
      add(:name, :string)
      add(:slug, :string)
      add(:description, :text)
      add(:tag_list, {:array, :string})
      add(:is_archived, :boolean, default: false, null: false)
      add(:is_private, :boolean, default: false, null: false)
      add(:thumbnail_url, :string)
      add(:license, :text)
      add(:data_type_id, references(:data_types, on_delete: :nothing))
      add(:label_type_id, references(:label_types, on_delete: :nothing))
      add(:user_owner_id, references(:users, on_delete: :delete_all))
      add(:company_owner_id, references(:organizations, on_delete: :nothing))

      timestamps()
    end

    create(index(:datasets, [:data_type_id]))
    create(index(:datasets, [:label_type_id]))
    create(index(:datasets, [:user_owner_id]))
    create(index(:datasets, [:company_owner_id]))

    create(unique_index(:datasets, [:user_owner_id, :name], name: :index_users_datasets))
    create(unique_index(:datasets, [:company_owner_id, :name], name: :index_companies_datasets))

    create(unique_index(:datasets, [:user_owner_id, :slug], name: :index_users_datasets_slug))

    create(
      unique_index(:datasets, [:company_owner_id, :slug], name: :index_companies_datasets_slug)
    )
  end
end
