defmodule Monkey.Datasets.DatasetFollower do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dataset_followers" do
    field(:user_id, :id)
    field(:dataset_id, :id)

    timestamps()
  end

  @doc false
  def changeset(dataset_follower, attrs) do
    dataset_follower
    |> cast(attrs, [])
    |> validate_required([])
  end
end
