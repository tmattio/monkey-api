defmodule Monkey.Datapoints.Text do
  use Ecto.Schema
  import Ecto.Changeset

  schema "data_texts" do
    field(:body, :string)
    field(:length, :integer)

    timestamps()
  end

  @doc false
  def changeset(text, attrs) do
    text
    |> cast(attrs, [:body, :length])
    |> validate_required([:body, :length])
  end
end
