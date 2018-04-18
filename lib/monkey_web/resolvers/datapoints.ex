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

  def upload_datapoints(_args, _info) do
    {:ok, nil}
  end
end
