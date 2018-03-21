defmodule MonkeyWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  import_types(__MODULE__.AccountTypes)
  import_types(__MODULE__.DatapointTypes)
  import_types(__MODULE__.DatasetTypes)
  import_types(__MODULE__.LabelTypes)
  import_types(__MODULE__.LabelingTaskTypes)

  alias MonkeyWeb.Resolvers

  @desc "The query root of Monkey's GraphQL interface."
  query do
    @desc "Lookup a given dataset by the owner and dataset name."
    field :dataset, :dataset do
      @desc "The login field of a user or organization."
      arg(:owner, non_null(:string))

      @desc "The name of the dataset."
      arg(:name, non_null(:string))

      resolve(&Resolvers.Dataset.get_dataset/2)
    end

    @desc "Perform a search across datasets."
    field :search_datasets, list_of(:dataset) do
      @desc "Returns the first n elements from the list."
      arg(:first, :integer)

      @desc "Returns the elements in the list that come after the specified global ID."
      arg(:after, :string)

      @desc "Returns the last n elements from the list."
      arg(:last, :integer)

      @desc "Returns the elements in the list that come before the specified global ID."
      arg(:before, :string)

      @desc "The search string to look for."
      arg(:query, non_null(:string))

      resolve(&Resolvers.Dataset.search_datasets/2)
    end
  end

  @desc "The query root for implementing Monkey's GraphQL mutations."
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
