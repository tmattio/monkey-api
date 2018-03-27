defmodule MonkeyWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Monkey.Repo

  alias MonkeyWeb.Resolvers

  object :user do
    @desc "Identifies the primary key from the user."
    field(:id, non_null(:id))

    field(:avatar_url, :string)
    field(:bio, :string)
    field(:company, :string)
    field(:email, :string)
    field(:is_active, :boolean)
    field(:last_login, :datetime)
    field(:name, :string)
    field(:username, :string)
    field(:website_url, :string)

    field(:organization, :organization, resolve: assoc(:organization))
    field(:datasets, list_of(:dataset), resolve: assoc(:datasets))

    field(:followers, list_of(:user))
    field(:following, list_of(:user))
    field(:starred_datasets, list_of(:dataset))
    field(:followed_datasets, list_of(:dataset))
  end

  object :organization do
    @desc "Identifies the primary key from the organization."
    field(:id, non_null(:id))

    field(:avatar_url, :string)
    field(:billing_email, :string)
    field(:description, :string)
    field(:email, :string)
    field(:is_active, :boolean)
    field(:name, :string)
    field(:website_url, :string)

    field(:users, list_of(:user), resolve: assoc(:users))
    field(:datasets, list_of(:dataset), resolve: assoc(:datasets))
  end

  object :session do
    field(:token, :string)
  end

  input_object :update_user_input do
    field(:avatar_url, :string)
    field(:bio, :string)
    field(:company, :string)
    field(:email, :string)
    field(:name, :string)
    field(:username, :string)
    field(:password, :string)
    field(:website_url, :string)
  end

  input_object :update_organization_input do
    field(:avatar_url, :string)
    field(:billing_email, :string)
    field(:description, :string)
    field(:email, :string)
    field(:name, :string)
    field(:website_url, :string)
  end
end
