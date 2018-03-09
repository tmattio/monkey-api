defmodule Monkey.Datasets.DatasetFollower do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Accounts.User
  alias Monkey.Datasets.Dataset

  @required_fields ~w(user_id dataset_id)a

  schema "dataset_followers" do
    belongs_to(:user, User, foreign_key: :user_id)
    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(dataset_follower, attrs) do
    dataset_follower
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:user_id, name: :dataset_followers_user_id_dataset_id_index)
  end
end
