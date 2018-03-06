defmodule Monkey.Labels.ImageClass do
  use Ecto.Schema
  import Ecto.Changeset

  schema "label_image_classes" do
    field(:class, :string)

    timestamps()
  end

  @doc false
  def changeset(image_class, attrs) do
    image_class
    |> cast(attrs, [:class])
    |> validate_required([:class])
  end
end
