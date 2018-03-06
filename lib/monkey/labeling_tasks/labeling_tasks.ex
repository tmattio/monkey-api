defmodule Monkey.LabelingTasks do
  @moduledoc """
  The LabelingTasks context.
  """

  import Ecto.Query, warn: false
  alias Monkey.Repo

  alias Monkey.LabelingTasks.LabelingTask

  @doc """
  Returns the list of labeling_tasks.

  ## Examples

      iex> list_labeling_tasks()
      [%LabelingTask{}, ...]

  """
  def list_labeling_tasks do
    Repo.all(LabelingTask)
  end

  @doc """
  Gets a single labeling_task.

  Raises `Ecto.NoResultsError` if the Labeling task does not exist.

  ## Examples

      iex> get_labeling_task!(123)
      %LabelingTask{}

      iex> get_labeling_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_labeling_task!(id), do: Repo.get!(LabelingTask, id)

  @doc """
  Creates a labeling_task.

  ## Examples

      iex> create_labeling_task(%{field: value})
      {:ok, %LabelingTask{}}

      iex> create_labeling_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_labeling_task(attrs \\ %{}) do
    %LabelingTask{}
    |> LabelingTask.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a labeling_task.

  ## Examples

      iex> update_labeling_task(labeling_task, %{field: new_value})
      {:ok, %LabelingTask{}}

      iex> update_labeling_task(labeling_task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_labeling_task(%LabelingTask{} = labeling_task, attrs) do
    labeling_task
    |> LabelingTask.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LabelingTask.

  ## Examples

      iex> delete_labeling_task(labeling_task)
      {:ok, %LabelingTask{}}

      iex> delete_labeling_task(labeling_task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_labeling_task(%LabelingTask{} = labeling_task) do
    Repo.delete(labeling_task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking labeling_task changes.

  ## Examples

      iex> change_labeling_task(labeling_task)
      %Ecto.Changeset{source: %LabelingTask{}}

  """
  def change_labeling_task(%LabelingTask{} = labeling_task) do
    LabelingTask.changeset(labeling_task, %{})
  end
end
