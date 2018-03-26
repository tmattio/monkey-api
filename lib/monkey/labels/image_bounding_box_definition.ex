defmodule Monkey.Labels.ImageBoundingBoxDefinition do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.Dataset
  alias Monkey.Labels.LabelType

  @required_fields ~w(classes dataset_id)a

  schema "label_image_bounding_box_definitions" do
    field(:classes, {:array, :string})

    belongs_to(:label_type, LabelType, foreign_key: :label_type_id)
    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    timestamps()
  end

  @doc false
  def changeset(image_bounding_box_definition, attrs) do
    image_bounding_box_definition
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:dataset)
    |> assoc_constraint(:label_type)
    |> unique_constraint(:dataset_id)
  end
end
