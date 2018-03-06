defmodule Monkey.Datasets.DatasetStargazer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dataset_stargazers" do
    field(:user_id, :id)
    field(:dataset_id, :id)

    timestamps()
  end

  @doc false
  def changeset(dataset_stargazer, attrs) do
    dataset_stargazer
    |> cast(attrs, [])
    |> validate_required([])
  end
end
