defmodule MonkeyWeb.Resolvers.Dataset do
  import Ecto.Query, only: [where: 2]

  alias Monkey.Repo
  alias Monkey.Datasets.Dataset

  def get_dataset(%{owner: owner, name: name}, %Absinthe.Resolution{} = info) do
    dataset = Repo.get_by(Dataset, name: name)

    preload_datapoints =
      Enum.any?(info.definition.selections, fn element ->
        match?(%{name: "datapoints"}, element)
      end)

    datapoints =
      if preload_datapoints do
        data_type = Ecto.assoc(dataset, :data_type) |> Repo.one()

        case data_type.name do
          "Image" -> Ecto.assoc(dataset, :data_images) |> Repo.all()
          "Video" -> Ecto.assoc(dataset, :data_videos) |> Repo.all()
          "Text" -> Ecto.assoc(dataset, :data_texts) |> Repo.all()
          _ -> []
        end
      else
        []
      end

    preload_labels =
      Enum.any?(info.definition.selections, fn element ->
        match?(%{name: "labels"}, element)
      end)

    labels =
      if preload_labels do
        label_type = Ecto.assoc(dataset, :label_type) |> Repo.one()

        case label_type.name do
          "Image Classification" ->
            Ecto.assoc(dataset, :label_image_classes) |> Repo.all()

          "Image Object Detection" ->
            Ecto.assoc(dataset, :label_image_bounding_boxes) |> Repo.all()

          _ ->
            []
        end
      else
        []
      end

    loaded_dataset =
      dataset
      |> Map.put_new(:datapoints, datapoints)
      |> Map.put_new(:labels, labels)

    {:ok, loaded_dataset}
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
