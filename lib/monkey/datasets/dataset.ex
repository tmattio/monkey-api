defmodule Monkey.Datasets.Dataset do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Accounts.{User, Organization}
  alias Monkey.Datapoints.DataType
  alias Monkey.Datasets.{DataACL, DatasetFollower, DatasetStargazer, LabelACL, LabelDefinitionACL}
  alias Monkey.LabelingTasks.LabelingTask

  @required_fields ~w(is_archived is_private label_definition_id name data_type_id)a
  @optional_fields ~w(description license tag_list thumbnail_url user_owner_id company_owner_id)a

  schema "datasets" do
    field(:description, :string)
    field(:is_archived, :boolean, default: false)
    field(:is_private, :boolean, default: false)
    field(:label_definition_id, :binary)
    field(:license, :string)
    field(:name, :string)
    field(:tag_list, {:array, :string})
    field(:thumbnail_url, :string)

    belongs_to(:data_type, DataType, foreign_key: :data_type_id)
    belongs_to(:user_owner, User, foreign_key: :user_owner_id)
    belongs_to(:company_owner, Organization, foreign_key: :company_owner_id)

    has_many(:data_acls, DataACL, foreign_key: :data_acl_id)
    has_many(:dataset_followers, DatasetFollower, foreign_key: :dataset_follower_id)
    has_many(:dataset_stargazers, DatasetStargazer, foreign_key: :dataset_stargazer_id)
    has_many(:label_acls, LabelACL, foreign_key: :label_acl_id)
    has_many(:label_definition_acls, LabelDefinitionACL, foreign_key: :label_definition_acl_id)
    has_many(:labeling_tasks, LabelingTask, foreign_key: :labeling_task_id)

    timestamps()
  end

  def validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      # Add the error to the first field only since Ecto requires a field name for each error.
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect(fields)}")
    end
  end

  def present?(changeset, field) do
    get_field(changeset, field) != nil
  end

  @doc false
  def changeset(dataset, attrs) do
    dataset
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_required_inclusion([:user_owner_id, :company_owner_id])
    |> unique_constraint(:user_datasets, name: :index_users_datasets)
    |> unique_constraint(:company_datasets, name: :index_companies_datasets)
  end
end
