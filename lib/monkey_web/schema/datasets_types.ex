defmodule MonkeyWeb.Schema.DatasetTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  use Absinthe.Ecto, repo: Monkey.Repo

  alias MonkeyWeb.Resolvers

  @desc "A repository contains labels for a set of data."
  object :dataset do
    @desc "Identifies the primary key from the dataset."
    field(:id, non_null(:id))

    @desc "The description of the dataset."
    field(:description, :string)

    @desc "Indicates if the dataset is unmaintained."
    field(:is_archived, non_null(:boolean))

    @desc "Identifies if the dataset is private."
    field(:is_private, non_null(:boolean))

    @desc "The license of the repository."
    field(:license, :string)

    @desc "The name of the repository."
    field(:name, non_null(:string))

    @desc "The slug of the dataset"
    field(:slug, non_null(:string))

    @desc "A list of tags for this repository."
    field(:tag_list, list_of(non_null(:string)))

    @desc "The HTTP URL of the thumbnail for this repository."
    field(:thumbnail_url, :string)

    @desc "Returns the data type for this repository."
    field(:data_type, non_null(:data_type), resolve: assoc(:data_type))

    @desc "Returns the label definition for this repository."
    field(:label_definition, non_null(:label_definition))

    @desc "The User owner of the repository."
    field(:owner, non_null(:user), resolve: assoc(:user_owner))

    @desc "Get the datapoints of a dataset."
    connection field(:datapoints, node_type: :datapoint) do
      resolve(&Resolvers.Datapoints.get_datapoints/2)
    end
  end

  object :dataset_export_payload do
    field(:export_url, :string)
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

  input_object :create_dataset_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:data_type, non_null(:string))
    field(:label_type, non_null(:string))
    field(:label_definition, non_null(:label_definition_input))
  end
end
