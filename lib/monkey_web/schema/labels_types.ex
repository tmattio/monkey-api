defmodule MonkeyWeb.Schema.LabelTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  use Absinthe.Ecto, repo: Monkey.Repo

  alias Monkey.Labels.{
    ImageClass,
    ImageBoundingBox,
    ImageClassDefinition,
    ImageBoundingBoxDefinition
  }

  object :label_type do
    field(:name, non_null(:string))
    field(:data_type, non_null(:data_type), resolve: assoc(:data_type))
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

  input_object :image_class_input do
    field(:class, :string)
  end

  input_object :image_bounding_box_input do
    field(:class, :string)
    field(:x_max, :float)
    field(:x_min, :float)
    field(:y_max, :float)
    field(:y_min, :float)
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

  input_object :image_class_definition_input do
    field(:classes, non_null(list_of(non_null(:string))))
  end

  input_object :image_bounding_box_definition_input do
    field(:classes, non_null(list_of(non_null(:string))))
  end

  # TODO(tmattio): GraphQL does not support union for input objects
  # So we use a composition instead.
  # There is some work in progress to support union in inputs:
  # https://github.com/facebook/graphql/pull/395
  input_object :label_definition_input do
    field(:image_class_definition, :image_class_definition_input)
    field(:image_bounding_box_definition, :image_bounding_box_definition_input)
  end

  input_object :label_input do
    field(:image_class, :image_class_input)
    field(:image_bounding_box, :image_bounding_box_input)
  end
end
