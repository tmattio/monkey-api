defmodule MonkeyWeb.Resolvers.Dataset do
  import Ecto.Query, only: [where: 2]

  alias Monkey.Repo
  alias Monkey.Datasets.Dataset

  def get_dataset(%{owner: owner, name: name}, %Absinthe.Resolution{} = info) do
    dataset = Repo.get_by(Dataset, name: name)

    queried_fields =
      Absinthe.Resolution.project(info)
      |> Enum.map(& &1.name)

    datapoints =
      if Enum.member?(queried_fields, "datapoints") do
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

    labels =
      if Enum.member?(queried_fields, "labels") do
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

    label_definition =
      if Enum.member?(queried_fields, "labelDefinition") do
        # TODO(tmattio): We query twice for the label type, refactor this.
        label_type = Ecto.assoc(dataset, :label_type) |> Repo.one()

        case label_type.name do
          "Image Classification" ->
            Ecto.assoc(dataset, :label_image_class_definition) |> Repo.one()

          "Image Object Detection" ->
            Ecto.assoc(dataset, :label_image_bounding_box_definition) |> Repo.one()

          _ ->
            nil
        end
      else
        nil
      end

    loaded_dataset =
      dataset
      |> Map.put_new(:datapoints, datapoints)
      |> Map.put_new(:labels, labels)
      |> Map.put_new(:label_definition, label_definition)

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
