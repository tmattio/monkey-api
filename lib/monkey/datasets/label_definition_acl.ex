defmodule Monkey.Datasets.LabelDefinitionACL do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.{Dataset}
  alias Monkey.Labels.{LabelType, ImageClassDefinition, ImageBoundingBoxDefinition}

  @required_fields ~w(label_type_id dataset_id)a
  @optional_fields ~w(image_class_id image_bounding_box_id)a

  schema "label_definitions_acls" do
    belongs_to(:label_type, LabelType, foreign_key: :label_type_id)
    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    belongs_to(
      :image_class,
      ImageClassDefinition,
      foreign_key: :image_class_id
    )

    belongs_to(
      :image_bounding_box,
      ImageBoundingBoxDefinition,
      foreign_key: :image_bounding_box_id
    )
  end

  @doc false
  def changeset(label_definition_acl, attrs) do
    label_definition_acl
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:label_type)
    |> assoc_constraint(:image_class)
    |> assoc_constraint(:image_bounding_box)
    |> unique_constraint(:dataset_id)
    |> unique_constraint(:image_class_id)
    |> unique_constraint(:image_bounding_box_id)
  end
end
