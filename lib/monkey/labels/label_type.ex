defmodule Monkey.Labels.LabelType do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datapoints.DataType
  alias Monkey.Datasets.{LabelACL, LabelDefinitionACL}

  @required_fields ~w(name data_type_id)a

  schema "label_types" do
    field(:name, :string)

    belongs_to(:data_type, DataType, foreign_key: :data_type_id)

    has_many(:label_acls, LabelACL, foreign_key: :label_acl_id)
    has_many(:label_definition_acls, LabelDefinitionACL, foreign_key: :label_definition_acl_id)
  end

  @doc false
  def changeset(label_type, attrs) do
    label_type
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
