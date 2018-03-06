defmodule MonkeyWeb.LabelingTaskView do
  use MonkeyWeb, :view
  alias MonkeyWeb.LabelingTaskView

  def render("index.json", %{labeling_tasks: labeling_tasks}) do
    %{data: render_many(labeling_tasks, LabelingTaskView, "labeling_task.json")}
  end

  def render("show.json", %{labeling_task: labeling_task}) do
    %{data: render_one(labeling_task, LabelingTaskView, "labeling_task.json")}
  end

  def render("labeling_task.json", %{labeling_task: labeling_task}) do
    %{
      id: labeling_task.id,
      due_date: labeling_task.due_date,
      due_labels: labeling_task.due_labels
    }
  end
end
