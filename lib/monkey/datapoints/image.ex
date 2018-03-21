defmodule Monkey.Datapoints.Image do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.DataACL

  @required_fields ~w(compression_format depth filesize height storage_path width)a
  @optional_fields ~w(caption)a

  schema "data_images" do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:filesize, :integer)
    field(:height, :integer)
    field(:storage_path, :string, unique: true)
    field(:width, :integer)

    has_one(:data_acl, DataACL, foreign_key: :image_id)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:storage_path)
  end
end
