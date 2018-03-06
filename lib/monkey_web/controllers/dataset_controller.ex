defmodule MonkeyWeb.DatasetController do
  use MonkeyWeb, :controller

  alias Monkey.Datasets
  alias Monkey.Datasets.Dataset

  action_fallback(MonkeyWeb.FallbackController)

  def index(conn, _params) do
    datasets = Datasets.list_datasets()
    render(conn, "index.json", datasets: datasets)
  end

  def create(conn, %{"dataset" => dataset_params}) do
    with {:ok, %Dataset{} = dataset} <- Datasets.create_dataset(dataset_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", dataset_path(conn, :show, dataset))
      |> render("show.json", dataset: dataset)
    end
  end

  def show(conn, %{"id" => id}) do
    dataset = Datasets.get_dataset!(id)
    render(conn, "show.json", dataset: dataset)
  end

  def update(conn, %{"id" => id, "dataset" => dataset_params}) do
    dataset = Datasets.get_dataset!(id)

    with {:ok, %Dataset{} = dataset} <- Datasets.update_dataset(dataset, dataset_params) do
      render(conn, "show.json", dataset: dataset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dataset = Datasets.get_dataset!(id)

    with {:ok, %Dataset{}} <- Datasets.delete_dataset(dataset) do
      send_resp(conn, :no_content, "")
    end
  end
end
