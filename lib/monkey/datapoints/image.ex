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

  def upload_image(base64_content) do
    {start, length} = :binary.match(base64_content, ";base64,")
    encoding = :binary.part(base64_content, 0, start)

    case encoding do
      "data:image/" <> compression ->
        raw =
          :binary.part(base64_content, start + length, byte_size(base64_content) - start - length)

        data = Base.decode64!(raw)
        filename = "images/" <> UUID.uuid4() <> "." <> compression
        File.write!(filename, data)

        {:ok,
         %{
           compression_format: compression,
           depth: 0,
           filesize: 0,
           height: 0,
           storage_path: filename,
           width: 0
         }}

      _ ->
        {:error, "The base64 string is not valid. Make sure it contains the mime type."}
    end
  end
end
