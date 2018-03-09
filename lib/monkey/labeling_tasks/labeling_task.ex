defmodule Monkey.LabelingTasks.LabelingTask do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Accounts.User
  alias Monkey.Datasets.Dataset

  @required_fields ~w(user_id dataset_id)a
  @optional_fields ~w(due_date due_labels)a

  schema "labeling_tasks" do
    field(:due_date, :naive_datetime)
    field(:due_labels, :integer)

    belongs_to(:user, User, foreign_key: :user_id)
    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    timestamps()
  end

  @doc false
  def changeset(labeling_task, attrs) do
    labeling_task
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
