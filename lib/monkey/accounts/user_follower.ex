defmodule Monkey.Accounts.UserFollower do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_followers" do
    field(:user_id, :id)
    field(:followee_id, :id)

    timestamps()
  end

  @doc false
  def changeset(user_follower, attrs) do
    user_follower
    |> cast(attrs, [])
    |> validate_required([])
  end
end
