defmodule Monkey.Labels.ImageBoundingBoxDefinition do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.LabelDefinitionACL

  @required_fields ~w(classes)a

  schema "label_image_bounding_box_definitions" do
    field(:classes, {:array, :string})

    has_one(:label_definition_acl, LabelDefinitionACL, foreign_key: :image_bounding_box_id)

    timestamps()
  end

  @doc false
  def changeset(image_bounding_box_definition, attrs) do
    image_bounding_box_definition
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
