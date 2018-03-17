defmodule Monkey.Repo.Migrations.AddDatasetsLabelDefinitionId do
  use Ecto.Migration

  def change do
    alter table(:datasets) do
      modify(:label_definition_id, references(:label_definitions_acls, on_delete: :nothing))
    end
  end
end
