defmodule Monkey.Repo.Migrations.CreateDataTexts do
  use Ecto.Migration

  def change do
    create table(:data_texts) do
      add(:body, :text)
      add(:length, :integer)
      add(:dataset_id, references(:datasets, on_delete: :delete_all))

      timestamps()
    end

    create(index(:data_texts, [:dataset_id]))
  end
end
