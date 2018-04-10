defmodule MonkeyWeb.Resolvers.Datasets do
  import Ecto.Query, only: [where: 2]

  alias Monkey.Repo
  alias Monkey.Datasets.Dataset
  alias Monkey.Datapoints.DataType
  alias Monkey.Labels.{LabelType, ImageBoundingBoxDefinition, ImageClassDefinition}

  def get_dataset(%{owner: owner, name: name}, %Absinthe.Resolution{} = info) do
    dataset = Monkey.Datasets.get_dataset(owner, name)

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

  def create_dataset(%{dataset: args}, %{context: %{current_user: current_user}}) do
    # TODO(tmattio): Investigate on how to make it atomic, we don't want a label definition
    # without a dataset or a dataset without label definition

    data_type = Repo.get_by!(DataType, name: args.data_type)
    label_type = Repo.get_by!(LabelType, name: args.label_type)

    label_definition =
      Enum.filter(args.label_definition, fn x -> x != nil end)
      |> Enum.at(0)

    dataset_args = %{
      data_type_id: data_type.id,
      label_type_id: label_type.id,
      user_owner_id: current_user.id,
      name: args.name,
      description: Map.get(args, :description)
    }

    {:ok, dataset} =
      %Dataset{}
      |> Dataset.changeset(dataset_args)
      |> Repo.insert()

    changeset =
      case label_definition do
        {:image_class_definition, struct} ->
          %ImageClassDefinition{}
          |> ImageClassDefinition.changeset(Map.put(struct, :dataset_id, dataset.id))

        {:image_bounding_box_definition, struct} ->
          %ImageBoundingBoxDefinition{}
          |> ImageBoundingBoxDefinition.changeset(Map.put(struct, :dataset_id, dataset.id))
      end

    {:ok, _label_definition} = Repo.insert(changeset)

    {:ok, dataset}
  end

  def create_dataset(_, _) do
    {:error, "You are not authenticated."}
  end

  def update_dataset(%{owner: owner, name: name, dataset: dataset_params}, %{
        context: %{current_user: current_user}
      }) do
    if owner == current_user.username do
      Monkey.Datasets.get_dataset(owner, name)
      |> Dataset.changeset(dataset_params)
      |> Repo.update()
    else
      {:error, "Only the owner of a dataset can update it."}
    end
  end

  def update_dataset(_, _) do
    {:error, "You are not authenticated."}
  end

  def delete_dataset(%{owner: owner, name: name}, %{context: %{current_user: current_user}}) do
    if owner == current_user.username do
      dataset = Monkey.Datasets.get_dataset(owner, name)
      Repo.delete(dataset)
    else
      {:error, "Only the owner of a dataset can delete it."}
    end
  end

  def delete_dataset(_, _) do
    {:error, "You are not authenticated."}
  end
end
