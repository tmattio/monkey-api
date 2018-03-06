defmodule MonkeyWeb.LabelingTaskController do
  use MonkeyWeb, :controller

  alias Monkey.LabelingTasks
  alias Monkey.LabelingTasks.LabelingTask

  action_fallback(MonkeyWeb.FallbackController)

  def index(conn, _params) do
    labeling_tasks = LabelingTasks.list_labeling_tasks()
    render(conn, "index.json", labeling_tasks: labeling_tasks)
  end

  def create(conn, %{"labeling_task" => labeling_task_params}) do
    with {:ok, %LabelingTask{} = labeling_task} <-
           LabelingTasks.create_labeling_task(labeling_task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", labeling_task_path(conn, :show, labeling_task))
      |> render("show.json", labeling_task: labeling_task)
    end
  end

  def show(conn, %{"id" => id}) do
    labeling_task = LabelingTasks.get_labeling_task!(id)
    render(conn, "show.json", labeling_task: labeling_task)
  end

  def update(conn, %{"id" => id, "labeling_task" => labeling_task_params}) do
    labeling_task = LabelingTasks.get_labeling_task!(id)

    with {:ok, %LabelingTask{} = labeling_task} <-
           LabelingTasks.update_labeling_task(labeling_task, labeling_task_params) do
      render(conn, "show.json", labeling_task: labeling_task)
    end
  end

  def delete(conn, %{"id" => id}) do
    labeling_task = LabelingTasks.get_labeling_task!(id)

    with {:ok, %LabelingTask{}} <- LabelingTasks.delete_labeling_task(labeling_task) do
      send_resp(conn, :no_content, "")
    end
  end
end
