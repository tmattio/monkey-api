defmodule MonkeyWeb.Resolvers.Dataset do
  import Ecto.Query, only: [where: 2]

  alias Monkey.Repo
  alias Monkey.Datasets.Dataset

  def get_dataset(%{owner: owner, name: name}, _info) do
    dataset = Repo.get_by(Dataset, name: name)
    {:ok, dataset}
  end

  def search_datasets(%{query: term}, _) do
    {:ok, Monkey.Datasets.search_datasets(term)}
  end

  def create_dataset(args, _info) do
    %Dataset{}
    |> Dataset.changeset(args)
    |> Repo.insert()
  end

  def update_dataset(%{id: id, dataset: dataset_params}, _info) do
    Repo.get!(Dataset, id)
    |> Dataset.changeset(dataset_params)
    |> Repo.update()
  end

  def delete_dataset(%{id: id}, _info) do
    dataset = Repo.get!(Dataset, id)
    Repo.delete(dataset)
  end
end
