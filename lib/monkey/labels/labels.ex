defmodule Monkey.Labels do
  @moduledoc """
  The Labels context.
  """

  def label_type_from_name(name) do
    case name do
      "Image Classification" ->
        {Monkey.Labels.ImageClass, Monkey.Labels.ImageClassDefinition}

      "Image Object Detection" ->
        {Monkey.Labels.ImageBoundingBox, Monkey.Labels.ImageBoundingBoxDefinition}

      _ ->
        {nil, nil}
    end
  end
end
