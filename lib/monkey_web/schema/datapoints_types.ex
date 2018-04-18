defmodule MonkeyWeb.Schema.DatapointTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  use Absinthe.Ecto, repo: Monkey.Repo
  alias Monkey.Datapoints.{Image, Text, Video}

  object :data_type do
    field(:name, non_null(:string))
    field(:label_types, non_null(list_of(non_null(:label_type))), resolve: assoc(:label_types))
  end

  interface :datapoint do
    field(:id, non_null(:id))
    field(:labels, non_null(list_of(non_null(:label))))

    resolve_type(fn
      %Image{}, _ -> :image
      %Text{}, _ -> :text
      %Video{}, _ -> :video
    end)
  end

  object :image do
    field(:id, non_null(:id))
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:filesize, :integer)
    field(:height, :integer)
    field(:storage_path, :string)
    field(:width, :integer)
    field(:labels, non_null(list_of(non_null(:label))))

    interface :datapoint
  end

  object :text do
    field(:id, non_null(:id))
    field(:body, :string)
    field(:length, :integer)
    field(:labels, non_null(list_of(non_null(:label))))

    interface :datapoint
  end

  object :video do
    field(:id, non_null(:id))
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:duration, :integer)
    field(:height, :integer)
    field(:storage_path, :string)
    field(:width, :integer)
    field(:labels, non_null(list_of(non_null(:label))))

    interface :datapoint
  end
end
