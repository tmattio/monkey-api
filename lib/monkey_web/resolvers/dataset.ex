defmodule MonkeyWeb.Resolvers.Dataset do
  import Ecto.Query, only: [where: 2]
  alias Monkey.Repo
  alias Monkey.Datasets.Dataset

  def list_datasets(_args, _info) do
    datasets =
      Dataset
      |> Repo.all()

    {:ok, datasets}
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
