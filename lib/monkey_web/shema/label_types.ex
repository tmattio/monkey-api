defmodule MonkeyWeb.Schema.LabelTypes do
  use Absinthe.Schema.Notation

  alias MonkeyWeb.Resolvers

  object :label_type do
    field(:name, :string)
  end
end
