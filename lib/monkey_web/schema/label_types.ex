defmodule MonkeyWeb.Schema.LabelTypes do
  use Absinthe.Schema.Notation

  alias MonkeyWeb.Resolvers
  alias Monkey.Labels.{ImageClass, ImageBoundingBox}

  object :label_type do
    field(:name, :string)
  end

  union :label do
    description("A label in a dataset.")

    types([:image_class, :image_bounding_box, :video])

    resolve_type(fn
      %ImageClass{}, _ -> :image_class
      %ImageBoundingBox{}, _ -> :image_bounding_box
    end)
  end

  object :image_class do
    field(:class, :string)
  end

  object :image_bounding_box do
    field(:class, :string)
    field(:x_max, :float)
    field(:x_min, :float)
    field(:y_max, :float)
    field(:y_min, :float)
  end
end
