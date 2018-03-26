defmodule Monkey.Datapoints.DataType do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.{Dataset}
  alias Monkey.Labels.LabelType

  @required_fields ~w(name table_name)a

  schema "data_types" do
    field(:name, :string, unique: true)

    has_many(:datasets, Dataset, foreign_key: :data_type_id)
    has_many(:label_types, LabelType, foreign_key: :data_type_id)
  end

  @doc false
  def changeset(data_type, attrs) do
    data_type
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
