defmodule Monkey.Labels.LabelType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "label_types" do
    field(:name, :string)
    field(:date_type_id, :id)

    timestamps()
  end

  @doc false
  def changeset(label_type, attrs) do
    label_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
