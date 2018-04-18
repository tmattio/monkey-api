defmodule MonkeyWeb.Resolvers.Datapoints do
  import Ecto.Query

  alias Monkey.Repo
  alias Monkey.Datapoints.DataType

  def list_data_types(_, _info) do
    data_types =
      DataType
      |> Repo.all()

    {:ok, data_types}
  end

  def get_datapoints(pagination_args, %{source: dataset}) do
    data_type = Ecto.assoc(dataset, :data_type) |> Repo.one()
    label_type = Ecto.assoc(dataset, :label_type) |> Repo.one()

    datapoints =
      case data_type.name do
        "Image" -> Ecto.assoc(dataset, :data_images)
        "Video" -> Ecto.assoc(dataset, :data_videos)
        "Text" -> Ecto.assoc(dataset, :data_texts)
        _ -> []
      end

    datapoints =
      case label_type.name do
        "Image Classification" ->
          datapoints
          |> preload(:label_image_classes)
          # |> select([d], %{d | labels: d.label_image_classes})
          |> Absinthe.Relay.Connection.from_query(&Repo.all/1, pagination_args)

        "Image Object Detection" ->
          datapoints
          |> preload(:label_image_bounding_boxes)
          # |> select([d], %{d | labels: d.label_image_bounding_boxes})
          |> Absinthe.Relay.Connection.from_query(&Repo.all/1, pagination_args)

        _ ->
          datapoints
      end

    datapoints
  end
end
