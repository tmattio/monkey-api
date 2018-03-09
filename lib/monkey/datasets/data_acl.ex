defmodule Monkey.Datasets.DataACL do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datapoints.{DataType, Image, Text, Video}
  alias Monkey.Datasets.Dataset

  @required_fields ~w(data_type_id dataset_id)a
  @optional_fields ~w(image_id video_id text_id)a

  schema "data_acls" do
    belongs_to(:data_type, DataType, foreign_key: :data_type_id)
    belongs_to(:image, Image, foreign_key: :data_image_id)
    belongs_to(:text, Text, foreign_key: :data_text_id)
    belongs_to(:video, Video, foreign_key: :data_video_id)
    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    timestamps()
  end

  @doc false
  def changeset(data_acl, attrs) do
    data_acl
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:dataset_id)
    |> unique_constraint(:image_id)
    |> unique_constraint(:video_id)
    |> unique_constraint(:text_id)
  end
end
