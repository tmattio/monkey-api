defmodule Monkey.Repo.Migrations.CreateLabelingTasks do
  use Ecto.Migration

  def change do
    create table(:labeling_tasks) do
      add(:due_date, :naive_datetime)
      add(:due_labels, :integer)
      add(:user_id, references(:users, on_delete: :nothing))
      add(:dataset_id, references(:datasets, on_delete: :nothing))

      timestamps()
    end

    create(index(:labeling_tasks, [:user_id]))
    create(index(:labeling_tasks, [:dataset_id]))
  end
end
