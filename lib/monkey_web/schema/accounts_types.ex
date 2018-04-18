defmodule MonkeyWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  use Absinthe.Ecto, repo: Monkey.Repo

  alias MonkeyWeb.Resolvers

  object :user do
    @desc "Identifies the primary key from the user."
    field(:id, non_null(:id))

    field(:avatar_url, :string)
    field(:bio, :string)
    field(:company, :string)
    field(:email, non_null(:string))
    field(:is_active, non_null(:boolean))
    field(:last_login, :datetime)
    field(:name, non_null(:string))
    field(:username, non_null(:string))
    field(:website_url, :string)

    field(:organization, :organization, resolve: assoc(:organization))
    field(:datasets, non_null(list_of(non_null(:dataset))), resolve: assoc(:datasets))

    field(:followers, non_null(list_of(non_null(:user))))
    field(:following, non_null(list_of(non_null(:user))))
    field(:starred_datasets, non_null(list_of(non_null(:dataset))))
    field(:followed_datasets, non_null(list_of(non_null(:dataset))))
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
    field(:token, non_null(:string))
    field(:user, non_null(:user))
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

  input_object :register_user_input do
    field(:email, non_null(:string))
    field(:name, non_null(:string))
    field(:username, non_null(:string))
    field(:password, non_null(:string))
  end
end
