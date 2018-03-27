defmodule MonkeyWeb.Schema do
  use Absinthe.Schema

  alias MonkeyWeb.Resolvers
  alias Monkey.Datasets

  @impl true
  def context(ctx) do
    # Foo source could be a Redis source
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Datasets, Datasets.data())

    Map.put(ctx, :loader, loader)
  end

  @impl true
  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  import_types(Absinthe.Type.Custom)

  import_types(__MODULE__.AccountTypes)
  import_types(__MODULE__.DatapointTypes)
  import_types(__MODULE__.DatasetTypes)
  import_types(__MODULE__.LabelTypes)
  import_types(__MODULE__.LabelingTaskTypes)

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

    field :data_types, non_null(list_of(non_null(:data_type))) do
      resolve(&Resolvers.Datapoint.list_data_types/2)
    end

    field :label_types, non_null(list_of(non_null(:label_type))) do
      resolve(&Resolvers.Label.list_label_types/2)
    end

    field :user, :user do
      arg(:username, non_null(:string))

      resolve(&Resolvers.Account.get_user/2)
    end

    field :viewer, :user do
      resolve(&Resolvers.Account.viewer/2)
    end
  end

  @desc "The query root for implementing Monkey's GraphQL mutations."
  mutation do
    field :create_dataset, :dataset do
      arg(:name, non_null(:string))
      arg(:label_definition_id, non_null(:id))
      arg(:data_type, non_null(:id))

      # TODO(tmattio): Allow to pass either a user or a company
      arg(:user_owner, non_null(:id))
      arg(:company_owner, :id)

      resolve(&Resolvers.Dataset.create_dataset/2)
    end

    field :update_dataset, type: :dataset do
      arg(:id, non_null(:id))
      arg(:dataset, :update_dataset_input)

      resolve(&Resolvers.Dataset.update_dataset/2)
    end

    field :delete_dataset, type: :dataset do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Dataset.delete_dataset/2)
    end

    field :update_user, type: :user do
      arg(:id, non_null(:integer))
      arg(:user, :update_user_input)

      resolve(&Resolvers.Account.update_user/2)
    end

    field :login, type: :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Account.login/2)
    end

    field :register, type: :user do
      arg(:email, non_null(:string))
      arg(:name, non_null(:string))
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Account.register/2)
    end
  end
end
