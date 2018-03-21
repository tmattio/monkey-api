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
      resolve(&Resolvers.Dataset.list_datasets/2)
    end
  end

  mutation do
    @desc "Create a dataset"
    field :create_dataset, :dataset do
      arg(:name, non_null(:string))
      arg(:label_definition_id, non_null(:id))
      arg(:data_type, non_null(:id))

      # TODO(tmattio): Allow to pass either a user or a company
      arg(:user_owner, non_null(:id))
      arg(:company_owner, :id)

      resolve(&Resolvers.Dataset.create_dataset/2)
    end

    @desc "Update a dataset"
    field :update_dataset, type: :dataset do
      arg(:id, non_null(:id))
      arg(:dataset, :update_dataset_input)

      resolve(&Resolvers.Dataset.update_dataset/2)
    end

    @desc "Delete a dataset"
    field :delete_dataset, type: :dataset do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Dataset.delete_dataset/2)
    end
  end
end
