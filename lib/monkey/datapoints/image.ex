defmodule Monkey.Datapoints.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "data_images" do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:filesize, :integer)
    field(:height, :integer)
    field(:storage_path, :string)
    field(:width, :integer)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [
      :caption,
      :storage_path,
      :filesize,
      :width,
      :height,
      :depth,
      :compression_format
    ])
    |> validate_required([
      :caption,
      :storage_path,
      :filesize,
      :width,
      :height,
      :depth,
      :compression_format
    ])
  end
end
