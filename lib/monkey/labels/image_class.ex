defmodule Monkey.Labels.ImageClass do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.LabelACL

  @required_fields ~w(class)a

  schema "label_image_classes" do
    field(:class, :string)

    has_one(:label_acl, LabelACL, foreign_key: :image_class_id)

    timestamps()
  end

  @doc false
  def changeset(image_class, attrs) do
    image_class
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
