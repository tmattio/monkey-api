defmodule MonkeyWeb.Resolvers.Datapoints do
  import Ecto.Query

  alias Monkey.Repo
  alias Monkey.Datapoints.DataType
  alias Monkey.Datapoints.{Image, Video, Text}

  def list_data_types(_, _info) do
    data_types =
      DataType
      |> Repo.all()

    {:ok, data_types}
  end

  def get_datapoints(pagination_args, %{source: dataset}) do
    data_type = Ecto.assoc(dataset, :data_type) |> Repo.one()

    data_field =
      case data_type.name do
        "Image" ->
          :data_images

        "Video" ->
          :data_videos

        "Text" ->
          :data_texts

        _ ->
          nil
      end

    from(
      d in Ecto.assoc(dataset, data_field),
      preload: [dataset: [:data_type, :label_type]]
    )
    |> Absinthe.Relay.Connection.from_query(&Repo.all/1, pagination_args)
  end

  def upload_datapoints(%{owner: owner, name: name, datapoints: datapoints}, %{
        context: %{current_user: current_user}
      }) do
    if owner == current_user.username do
      dataset = Monkey.Datasets.get_dataset!(owner, name)

      uploaded_datapoints =
        datapoints
        |> Enum.map(&add_datapoint(&1, dataset.id))

      {:ok, uploaded_datapoints}
    else
      {:error, "Only the owner of a dataset can upload datapoints."}
    end
  end

  def upload_datapoints(_, _) do
    {:error, "You are not authenticated."}
  end

  def add_datapoint(datapoint, dataset_id) do
    datapoint =
      Enum.filter(datapoint, fn x -> x != nil end)
      |> Enum.at(0)

    changeset =
      case datapoint do
        {:remote_image, struct} ->
          %Image{}
          |> Image.changeset(Map.put(struct, :dataset_id, dataset_id))

        {:upload_image, struct} ->
          case Image.upload_image(struct.content) do
            {:ok, image} ->
              image = Map.put(image, :dataset_id, dataset_id)

              %Image{}
              |> Image.changeset(image)

            {:error, _} = err ->
              err
          end

        {:text, struct} ->
          %Text{}
          |> Text.changeset(Map.put(struct, :dataset_id, dataset_id))
      end

    Repo.insert!(changeset)
  end
end
