defmodule Monkey.Labels.LabelType do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datapoints.DataType
  alias Monkey.Labels

  @required_fields ~w(name data_type_id)a

  schema "label_types" do
    field(:name, :string)

    belongs_to(:data_type, DataType, foreign_key: :data_type_id)
  end

  @doc false
  def changeset(label_type, attrs) do
    label_type
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:data_type)
    |> unique_constraint(:name)
  end
end
