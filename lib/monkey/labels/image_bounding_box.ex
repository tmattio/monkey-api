defmodule Monkey.Labels.ImageBoundingBox do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.LabelACL

  @required_fields ~w(class x_max x_min y_max y_min)a

  schema "label_image_bounding_boxes" do
    field(:class, :string)
    field(:x_max, :float)
    field(:x_min, :float)
    field(:y_max, :float)
    field(:y_min, :float)

    has_one(:label_acl, LabelACL, foreign_key: :label_acl_id)

    timestamps()
  end

  @doc false
  def changeset(image_bounding_box, attrs) do
    image_bounding_box
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
