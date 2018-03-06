defmodule Monkey.Accounts.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field(:avatar_url, :string)
    field(:billing_email, :string)
    field(:description, :string)
    field(:email, :string)
    field(:is_active, :boolean, default: false)
    field(:name, :string)
    field(:website_url, :string)

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [
      :avatar_url,
      :description,
      :email,
      :billing_email,
      :name,
      :website_url,
      :is_active
    ])
    |> validate_required([
      :avatar_url,
      :description,
      :email,
      :billing_email,
      :name,
      :website_url,
      :is_active
    ])
  end
end
