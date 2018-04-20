defmodule MonkeyWeb.Schema.DatapointTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  use Absinthe.Ecto, repo: Monkey.Repo
  alias Monkey.Datapoints.{Image, Text, Video}

  alias MonkeyWeb.Resolvers

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
    field(:compression_format, non_null(:string))
    field(:depth, non_null(:integer))
    field(:filesize, non_null(:integer))
    field(:height, non_null(:integer))
    field(:storage_path, non_null(:string))
    field(:width, non_null(:integer))

    field :labels, type: non_null(list_of(non_null(:label))) do
      resolve(&Resolvers.Labels.get_labels/3)
    end

    interface(:datapoint)
  end

  object :text do
    field(:id, non_null(:id))
    field(:body, non_null(:string))
    field(:length, non_null(:integer))
    field(:labels, non_null(list_of(non_null(:label))))

    interface(:datapoint)
  end

  object :video do
    field(:id, non_null(:id))
    field(:caption, :string)
    field(:compression_format, non_null(:string))
    field(:depth, non_null(:integer))
    field(:duration, non_null(:integer))
    field(:height, non_null(:integer))
    field(:storage_path, non_null(:string))
    field(:width, non_null(:integer))
    field(:labels, non_null(list_of(non_null(:label))))

    interface(:datapoint)
  end

  input_object :remote_image_input do
    field(:caption, :string)
    field(:compression_format, non_null(:string))
    field(:depth, non_null(:integer))
    field(:filesize, non_null(:integer))
    field(:height, non_null(:integer))
    field(:storage_path, non_null(:string))
    field(:width, non_null(:integer))
  end

  input_object :upload_image_input do
    field(:caption, :string)
    field(:compression_format, non_null(:string))
    field(:content, non_null(:string))
  end

  input_object :text_input do
    field(:content, non_null(:string))
  end

  input_object :video_input do
    field(:caption, :string)
    field(:content, non_null(:upload))
  end

  input_object :datapoint_input do
    field(:remote_image, :remote_image_input)
    field(:upload_image, :upload_image_input)
    field(:text, :text_input)
    field(:video, :video_input)
  end
end
