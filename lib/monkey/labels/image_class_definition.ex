defmodule Monkey.Labels.ImageClassDefinition do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.LabelDefinitionACL

  @required_fields ~w(classes)a

  schema "label_image_class_definitions" do
    field(:classes, {:array, :string})

    has_one(:label_definition_acl, LabelDefinitionACL, foreign_key: :label_definition_acl_id)

    timestamps()
  end

  @doc false
  def changeset(image_class_definition, attrs) do
    image_class_definition
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
