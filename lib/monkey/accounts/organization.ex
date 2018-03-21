defmodule Monkey.Accounts.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Accounts.User
  alias Monkey.Datasets.Dataset

  @required_fields ~w(email is_active name)a
  @optional_fields ~w(avatar_url billing_email description website_url)a

  schema "organizations" do
    field(:avatar_url, :string)
    field(:billing_email, :string, unique: true)
    field(:description, :string)
    field(:email, :string, unique: true)
    field(:is_active, :boolean, default: false)
    field(:name, :string, unique: true)
    field(:website_url, :string)

    has_many(:users, User, foreign_key: :organization_id)
    has_many(:datasets, Dataset, foreign_key: :company_owner_id)

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
    |> unique_constraint(:email)
    |> unique_constraint(:billing_email)
  end
end
