defmodule MonkeyWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(MonkeyWeb.Schema.AccountTypes)
  import_types(MonkeyWeb.Schema.DatapointTypes)
  import_types(MonkeyWeb.Schema.DatasetTypes)
  import_types(MonkeyWeb.Schema.LabelTypes)
  import_types(MonkeyWeb.Schema.LabelingTaskTypes)

  alias MonkeyWeb.Resolvers

  query do
    @desc "Get all datasets"
    field :datasets, list_of(:dataset) do
      resolve(&Resolvers.Dataset.list_datasets/3)
    end
  end

  mutation do
    @desc "Create a dataset"
    field :create_dataset, :dataset do
      arg(:description, :string)
      arg(:is_archived, :boolean)
      arg(:is_private, :boolean)
      arg(:label_definition_id, :id)
      arg(:license, :string)
      arg(:name, :string)
      arg(:tag_list, list_of(:string))
      arg(:thumbnail_url, :string)
      arg(:data_type, :id)
      arg(:user_owner, :id)
      arg(:company_owner, :id)

      resolve(&Resolvers.Dataset.create_dataset/3)
    end
  end
end
