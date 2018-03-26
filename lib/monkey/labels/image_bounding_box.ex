defmodule Monkey.Labels.ImageBoundingBox do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datapoints.Image
  alias Monkey.Datasets.Dataset

  @required_fields ~w(class x_max x_min y_max y_min dataset_id datapoint_id)a

  schema "label_image_bounding_boxes" do
    field(:class, :string)
    field(:x_max, :float)
    field(:x_min, :float)
    field(:y_max, :float)
    field(:y_min, :float)

    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)
    belongs_to(:datapoint, Image, foreign_key: :datapoint_id)

    timestamps()
  end

  @doc false
  def changeset(image_bounding_box, attrs) do
    image_bounding_box
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:dataset)
    |> assoc_constraint(:datapoint)
  end
end
