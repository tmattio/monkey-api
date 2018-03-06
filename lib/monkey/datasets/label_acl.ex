defmodule Monkey.Datasets.LabelACL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "label_acls" do
    field(:type_id, :id)
    field(:image_classification_id, :id)
    field(:object_detection_id, :id)
    field(:dataset_id, :id)

    timestamps()
  end

  @doc false
  def changeset(label_acl, attrs) do
    label_acl
    |> cast(attrs, [])
    |> validate_required([])
  end
end
