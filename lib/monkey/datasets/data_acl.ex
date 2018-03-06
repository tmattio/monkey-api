defmodule Monkey.Datasets.DataACL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "data_acls" do
    field(:type_id, :id)
    field(:image_id, :id)
    field(:video_id, :id)
    field(:text_id, :id)
    field(:dataset_id, :id)

    timestamps()
  end

  @doc false
  def changeset(data_acl, attrs) do
    data_acl
    |> cast(attrs, [])
    |> validate_required([])
  end
end
