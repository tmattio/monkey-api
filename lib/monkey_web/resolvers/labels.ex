defmodule MonkeyWeb.Resolvers.Labels do
  alias Monkey.Repo
  alias Monkey.Labels.LabelType

  def list_label_types(_, _info) do
    label_types =
      LabelType
      |> Repo.all()

    {:ok, label_types}
  end

  def get_label(parent, _args, %{context: %{loader: loader}}) do
    label_field =
      case parent.dataset.label_type.name do
        "Image Classification" ->
          :label_image_class

        "Image Object Detection" ->
          :label_image_bounding_box
      end

    label =
      Ecto.assoc(parent, label_field)
      |> Repo.one()

    {:ok, label}
  end
end
