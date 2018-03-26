defmodule Monkey.Datapoints.Text do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.Dataset

  @required_fields ~w(body length dataset_id)a

  schema "data_texts" do
    field(:body, :string)
    field(:length, :integer)

    belongs_to(:dataset, Dataset, foreign_key: :dataset_id)

    timestamps()
  end

  @doc false
  def changeset(text, attrs) do
    text
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:dataset)
  end
end
