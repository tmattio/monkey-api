defmodule MonkeyWeb.Schema.DatapointTypes do
  use Absinthe.Schema.Notation

  use Absinthe.Ecto, repo: Monkey.Repo
  alias Monkey.Datapoints.{Image, Text, Video}

  object :data_type do
    field(:name, :string)
    field(:label_types, non_null(list_of(non_null(:data_type))), resolve: assoc(:label_types))
  end

  union :datapoint do
    types([:image, :text, :video])

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
  end

  object :text do
    field(:id, non_null(:id))
    field(:body, :string)
    field(:length, :integer)
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
  end
end
