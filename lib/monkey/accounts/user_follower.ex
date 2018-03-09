defmodule Monkey.Accounts.UserFollower do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(user_id followee_id)a

  schema "user_followers" do
    field(:user_id, :id)
    field(:followee_id, :id)

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(user_follower, attrs) do
    user_follower
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:follow, name: :user_followers_pkey)
  end
end
