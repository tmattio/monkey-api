defmodule Monkey.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Accounts.Organization
  alias Monkey.Datasets.{DatasetFollower, DatasetStargazer, Dataset}
  alias Monkey.LabelingTasks.LabelingTask

  @required_fields ~w(email is_active password name username)a
  @optional_fields ~w(avatar_url bio company last_login website_url organization_id)a

  schema "users" do
    field(:avatar_url, :string)
    field(:bio, :string)
    field(:company, :string)
    field(:email, :string, unique: true)
    field(:is_active, :boolean, default: false)
    field(:last_login, :naive_datetime)
    field(:password, :string)
    field(:name, :string)
    field(:username, :string, unique: true)
    field(:website_url, :string)

    belongs_to(:organizations, Organization, foreign_key: :organization_id)

    has_many(:dataset_followers, DatasetFollower, foreign_key: :user_id)
    has_many(:dataset_stargazers, DatasetStargazer, foreign_key: :user_id)
    has_many(:datasets, Dataset, foreign_key: :user_owner_id)
    has_many(:labeling_tasks, LabelingTask, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
