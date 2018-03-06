defmodule Monkey.Labels.ImageBoundingBoxDefinition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "label_image_bounding_box_definitions" do
    field(:classes, {:array, :string})

    timestamps()
  end

  @doc false
  def changeset(image_bounding_box_definition, attrs) do
    image_bounding_box_definition
    |> cast(attrs, [:classes])
    |> validate_required([:classes])
  end
end
