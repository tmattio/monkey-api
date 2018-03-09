defmodule Monkey.Datapoints.DataType do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.{DataACL, Dataset}
  alias Monkey.Labels.LabelType

  @required_fields ~w(name)a

  schema "data_types" do
    field(:name, :string, unique: true)

    has_many(:data_acls, DataACL, foreign_key: :data_acl_id)
    has_many(:datasets, Dataset, foreign_key: :dataset_id)
    has_many(:label_types, LabelType, foreign_key: :label_type_id)

    timestamps()
  end

  @doc false
  def changeset(data_type, attrs) do
    data_type
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
