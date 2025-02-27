defmodule Monkey.Datapoints.Video do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.Dataset

  @required_fields ~w(compression_format depth duration height storage_path width dataset_id)a
  @optional_fields ~w(caption)a

  schema "data_videos" do
    field(:caption, :string)
    field(:compression_format, :string)
    field(:depth, :integer)
    field(:duration, :integer)
    field(:height, :integer)
    field(:storage_path, :string, unique: true)
    field(:width, :integer)

    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:storage_path)
    |> assoc_constraint(:dataset)
  end
end
