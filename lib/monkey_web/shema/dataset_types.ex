defmodule MonkeyWeb.Schema.DatasetTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Monkey.Repo

  alias Monkey.Datapoints.DataType
  alias MonkeyWeb.Resolvers

  object :data_type do
    field(:name, :string)
  end

  object :dataset do
    field(:id, :id)
    field(:description, :string)
    field(:is_archived, :boolean)
    field(:is_private, :boolean)
    field(:label_definition_id, :id)
    field(:license, :string)
    field(:name, :string)
    field(:slug, :string)
    field(:tag_list, list_of(:string))
    field(:thumbnail_url, :string)
    field(:data_type, :data_type, resolve: assoc(:data_type))
    field(:user_owner, :integer)
    field(:company_owner, :integer)
  end

  input_object :update_dataset_input do
    field(:name, :string)
    field(:description, :string)
    field(:is_archived, :boolean)
    field(:is_private, :boolean)
    field(:license, :string)
    field(:tag_list, list_of(:string))
    field(:thumbnail_url, :string)
  end
end
