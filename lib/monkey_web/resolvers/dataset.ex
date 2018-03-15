defmodule MonkeyWeb.Resolvers.Dataset do
  
  def list_datasets(_parent, _args, _resolution) do
    {:ok, Monkey.Datasets.list_datasets()}
  end

  def create_dataset(_parent, args, _resolution) do
    Monkey.Datasets.create_dataset(args)
  end
end
