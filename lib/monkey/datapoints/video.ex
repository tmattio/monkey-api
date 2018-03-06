defmodule Monkey.Datapoints.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "data_videos" do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:duration, :integer)
    field(:height, :integer)
    field(:storage_path, :string)
    field(:width, :integer)

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [
      :caption,
      :storage_path,
      :width,
      :height,
      :depth,
      :compression_format,
      :duration
    ])
    |> validate_required([
      :caption,
      :storage_path,
      :width,
      :height,
      :depth,
      :compression_format,
      :duration
    ])
  end
end
