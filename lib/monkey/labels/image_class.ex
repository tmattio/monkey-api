defmodule Monkey.Labels.ImageClass do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datapoints.Image
  alias Monkey.Datasets.Dataset

  @required_fields ~w(class dataset_id datapoint_id)a

  schema "label_image_classes" do
    field(:class, :string)

    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)
    belongs_to(:datapoint, Image, foreign_key: :datapoint_id)

    timestamps()
  end

  @doc false
  def changeset(image_class, attrs) do
    image_class
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:dataset)
    |> assoc_constraint(:datapoint)
  end
end
