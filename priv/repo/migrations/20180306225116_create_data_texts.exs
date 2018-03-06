defmodule Monkey.Repo.Migrations.CreateDataTexts do
  use Ecto.Migration

  def change do
    create table(:data_texts) do
      add(:body, :text)
      add(:length, :integer)

      timestamps()
    end
  end
end
