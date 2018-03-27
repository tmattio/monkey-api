defmodule MonkeyWeb.Schema.LabelTypes do
  use Absinthe.Schema.Notation

  use Absinthe.Ecto, repo: Monkey.Repo

  alias Monkey.Labels.{
    ImageClass,
    ImageBoundingBox,
    ImageClassDefinition,
    ImageBoundingBoxDefinition
  }

  object :label_type do
    field(:name, :string)
    field(:data_type, :data_type, resolve: assoc(:data_type))
  end

  union :label do
    types([:image_class, :image_bounding_box])

    resolve_type(fn
      %ImageClass{}, _ -> :image_class
      %ImageBoundingBox{}, _ -> :image_bounding_box
    end)
  end

  object :image_class do
    field(:id, non_null(:id))
    field(:class, :string)
    field(:datapoint, non_null(:image), resolve: assoc(:datapoint))
  end

  object :image_bounding_box do
    field(:id, non_null(:id))
    field(:class, :string)
    field(:x_max, :float)
    field(:x_min, :float)
    field(:y_max, :float)
    field(:y_min, :float)
    field(:datapoint, non_null(:image), resolve: assoc(:datapoint))
  end

  union :label_definition do
    types([:image_class_definition, :image_bounding_box_definition])

    resolve_type(fn
      %ImageClassDefinition{}, _ -> :image_class_definition
      %ImageBoundingBoxDefinition{}, _ -> :image_bounding_box_definition
    end)
  end

  object :image_class_definition do
    field(:classes, non_null(list_of(non_null(:string))))
  end

  object :image_bounding_box_definition do
    field(:classes, non_null(list_of(non_null(:string))))
  end
end
