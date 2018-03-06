defmodule Monkey.Labels.ImageClassDefinition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "label_image_class_definitions" do
    field(:classes, {:array, :string})

    timestamps()
  end

  @doc false
  def changeset(image_class_definition, attrs) do
    image_class_definition
    |> cast(attrs, [:classes])
    |> validate_required([:classes])
  end
end
