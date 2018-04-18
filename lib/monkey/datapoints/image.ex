defmodule Monkey.Datapoints.Image do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.Dataset
  alias Monkey.Labels

  @required_fields ~w(compression_format depth filesize height storage_path width dataset_id)a
  @optional_fields ~w(caption)a

  schema "data_images" do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:filesize, :integer)
    field(:height, :integer)
    field(:storage_path, :string, unique: true)
    field(:width, :integer)

    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    has_many(:label_image_classes, Labels.ImageClass, foreign_key: :datapoint_id)
    has_many(:label_image_bounding_boxes, Labels.ImageBoundingBox, foreign_key: :datapoint_id)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:storage_path)
    |> assoc_constraint(:dataset)
  end
end
