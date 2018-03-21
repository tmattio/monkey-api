defmodule MonkeyWeb.Schema.DatapointTypes do
  use Absinthe.Schema.Notation

  alias MonkeyWeb.Resolvers

  object :data_type do
    field(:name, :string)
  end
end
