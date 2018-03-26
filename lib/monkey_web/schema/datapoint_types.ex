defmodule MonkeyWeb.Schema.DatapointTypes do
  use Absinthe.Schema.Notation

  alias Monkey.Datapoints.{Image, Text, Video}

  object :data_type do
    field(:name, :string)
  end

  union :datapoint do
    description("A datapoint in a dataset.")

    types([:image, :text, :video])

    resolve_type(fn
      %Image{}, _ -> :image
      %Text{}, _ -> :text
      %Video{}, _ -> :video
    end)
  end

  object :image do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:filesize, :integer)
    field(:height, :integer)
    field(:storage_path, :string)
    field(:width, :integer)
  end

  object :text do
    field(:body, :string)
    field(:length, :integer)
  end

  object :video do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:duration, :integer)
    field(:height, :integer)
    field(:storage_path, :string)
    field(:width, :integer)
  end
end
