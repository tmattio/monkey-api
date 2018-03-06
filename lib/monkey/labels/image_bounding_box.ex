defmodule Monkey.Labels.ImageBoundingBox do
  use Ecto.Schema
  import Ecto.Changeset

  schema "label_image_bounding_boxes" do
    field(:class, :string)
    field(:x_max, :float)
    field(:x_min, :float)
    field(:y_max, :float)
    field(:y_min, :float)

    timestamps()
  end

  @doc false
  def changeset(image_bounding_box, attrs) do
    image_bounding_box
    |> cast(attrs, [:x_min, :x_max, :y_min, :y_max, :class])
    |> validate_required([:x_min, :x_max, :y_min, :y_max, :class])
  end
end
