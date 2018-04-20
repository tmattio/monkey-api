defmodule MonkeyWeb.Resolvers.Labels do
  import Ecto.Query

  alias Monkey.Repo
  alias Monkey.Datasets.Dataset
  alias Monkey.Accounts.User
  alias Monkey.Labels.LabelType
  alias Monkey.Labels.{ImageClass, ImageBoundingBox}

  def list_label_types(_, _info) do
    label_types =
      LabelType
      |> Repo.all()

    {:ok, label_types}
  end

  def get_labels(parent, _args, %{context: %{loader: loader}}) do
    label_field =
      case parent.dataset.label_type.name do
        "Image Classification" ->
          :label_image_classes

        "Image Object Detection" ->
          :label_image_bounding_boxes
      end

    labels =
      Ecto.assoc(parent, label_field)
      |> Repo.all()

    {:ok, labels}
  end

  def update_label(%{owner: owner, name: name, datapoint_id: datapoint_id, label: label}, %{
        context: %{current_user: current_user}
      }) do
    if owner == current_user.username do
      dataset =
        Repo.one(
          from(
            d in Dataset,
            join: u in User,
            where: u.username == ^owner and d.slug == ^name,
            preload: [:data_type]
          )
        )

      label =
        Enum.filter(label, fn x -> x != nil end)
        |> Enum.at(0)

      {label_type, label_struct} =
        case label do
          {:image_class, label_struct} ->
            {ImageClass, label_struct}

          {:image_bounding_box, label_struct} ->
            {ImageBoundingBox, label_struct}
        end

      existing_label =
        from(
          q in label_type,
          where: q.dataset_id == ^dataset.id and q.datapoint_id == ^datapoint_id
        )

      Repo.delete_all(existing_label)

      label_struct =
        label_struct
        |> Map.put(:datapoint_id, datapoint_id)
        |> Map.put(:dataset_id, dataset.id)

      # TODO(tmattio): Validate with the label definition
      changeset =
        struct(label_type, %{})
        |> label_type.changeset(label_struct)

      changeset
      |> Repo.insert()
    else
      {:error, "Only the owner of a dataset can update it."}
    end
  end

  def update_label(_, _) do
    {:error, "You are not authenticated."}
  end
end
