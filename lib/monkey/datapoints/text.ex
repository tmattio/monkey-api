defmodule Monkey.Datapoints.Text do
  use Ecto.Schema
  import Ecto.Changeset

  alias Monkey.Datasets.DataACL

  @required_fields ~w(body length)a

  schema "data_texts" do
    field(:body, :string)
    field(:length, :integer)

    has_one(:data_acl, DataACL, foreign_key: :text_id)

    timestamps()
  end

  @doc false
  def changeset(text, attrs) do
    text
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
