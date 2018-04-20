defmodule Monkey.Datapoints do
  @moduledoc """
  The Labels context.
  """

  def data_type_from_name(name) do
    case name do
      "Image" ->
        Monkey.Datapoints.Image

      "Text" ->
        Monkey.Datapoints.Text

      "Video" ->
        Monkey.Datapoints.Video

      _ ->
        nil
    end
  end

  def get_label_assoc_name(type) do
    case type do
      Monkey.Labels.ImageClass ->
        :label_image_classes

      Monkey.Labels.ImageBoundingBox ->
        :label_image_bounding_boxes
    end
  end
end
