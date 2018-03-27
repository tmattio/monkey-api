defmodule MonkeyWeb.Resolvers.Datapoints do
  alias Monkey.Repo
  alias Monkey.Datapoints.DataType

  def list_data_types(_, _info) do
    data_types =
      DataType
      |> Repo.all()

    {:ok, data_types}
  end
end
