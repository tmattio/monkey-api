defmodule Monkey.Datapoints.Video do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.DataACL

  @required_fields ~w(compression_format depth duration height storage_path width)a
  @optional_fields ~w(caption)a

  schema "data_videos" do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:duration, :integer)
    field(:height, :integer)
    field(:storage_path, :string, unique: true)
    field(:width, :integer)

    has_one(:data_acl, DataACL, foreign_key: :video_id)

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:storage_path)
  end
end
