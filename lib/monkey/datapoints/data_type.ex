defmodule Monkey.Datapoints.DataType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "data_types" do
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(data_type, attrs) do
    data_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
