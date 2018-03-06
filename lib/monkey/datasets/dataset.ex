defmodule Monkey.Datasets.Dataset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "datasets" do
    field(:description, :string)
    field(:is_archived, :boolean, default: false)
    field(:is_private, :boolean, default: false)
    field(:label_definition_id, :binary)
    field(:license, :string)
    field(:name, :string)
    field(:tag_list, {:array, :string})
    field(:thumbnail_url, :string)
    field(:data_type_id, :id)
    field(:user_owner_id, :id)
    field(:company_owner_id, :id)

    timestamps()
  end

  @doc false
  def changeset(dataset, attrs) do
    dataset
    |> cast(attrs, [
      :name,
      :description,
      :label_definition_id,
      :tag_list,
      :is_archived,
      :is_private,
      :thumbnail_url,
      :license
    ])
    |> validate_required([
      :name,
      :description,
      :label_definition_id,
      :tag_list,
      :is_archived,
      :is_private,
      :thumbnail_url,
      :license
    ])
  end
end
