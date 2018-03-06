defmodule Monkey.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:avatar_url, :string)
    field(:bio, :string)
    field(:company, :string)
    field(:email, :string)
    field(:is_active, :boolean, default: false)
    field(:last_login, :naive_datetime)
    field(:password, :string)
    field(:username, :string)
    field(:website_url, :string)
    field(:organization_id, :id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :password,
      :username,
      :bio,
      :avatar_url,
      :website_url,
      :company,
      :last_login,
      :is_active
    ])
    |> validate_required([
      :email,
      :password,
      :username,
      :bio,
      :avatar_url,
      :website_url,
      :company,
      :last_login,
      :is_active
    ])
  end
end
