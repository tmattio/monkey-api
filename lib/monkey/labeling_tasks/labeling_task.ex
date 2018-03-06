defmodule Monkey.LabelingTasks.LabelingTask do
  use Ecto.Schema
  import Ecto.Changeset

  schema "labeling_tasks" do
    field(:due_date, :naive_datetime)
    field(:due_labels, :integer)
    field(:user_id, :id)
    field(:dataset_id, :id)

    timestamps()
  end

  @doc false
  def changeset(labeling_task, attrs) do
    labeling_task
    |> cast(attrs, [:due_date, :due_labels])
    |> validate_required([:due_date, :due_labels])
  end
end
