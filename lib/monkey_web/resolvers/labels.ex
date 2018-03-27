defmodule MonkeyWeb.Resolvers.Labels do
  alias Monkey.Repo
  alias Monkey.Labels.LabelType

  def list_label_types(_, _info) do
    label_types =
      LabelType
      |> Repo.all()

    {:ok, label_types}
  end
end
