defmodule MonkeyWeb.DatasetView do
  use MonkeyWeb, :view
  alias MonkeyWeb.DatasetView

  def render("index.json", %{datasets: datasets}) do
    %{data: render_many(datasets, DatasetView, "dataset.json")}
  end

  def render("show.json", %{dataset: dataset}) do
    %{data: render_one(dataset, DatasetView, "dataset.json")}
  end

  def render("dataset.json", %{dataset: dataset}) do
    %{
      id: dataset.id,
      name: dataset.name,
      description: dataset.description,
      label_definition_id: dataset.label_definition_id,
      tag_list: dataset.tag_list,
      is_archived: dataset.is_archived,
      is_private: dataset.is_private,
      thumbnail_url: dataset.thumbnail_url,
      license: dataset.license
    }
  end
end
