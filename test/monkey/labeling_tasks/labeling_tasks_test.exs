defmodule Monkey.LabelingTasksTest do
  use Monkey.DataCase

  alias Monkey.LabelingTasks

  describe "labeling_tasks" do
    alias Monkey.LabelingTasks.LabelingTask

    @valid_attrs %{due_date: ~N[2010-04-17 14:00:00.000000], due_labels: 42}
    @update_attrs %{due_date: ~N[2011-05-18 15:01:01.000000], due_labels: 43}
    @invalid_attrs %{due_date: nil, due_labels: nil}

    def labeling_task_fixture(attrs \\ %{}) do
      {:ok, labeling_task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LabelingTasks.create_labeling_task()

      labeling_task
    end

    test "list_labeling_tasks/0 returns all labeling_tasks" do
      labeling_task = labeling_task_fixture()
      assert LabelingTasks.list_labeling_tasks() == [labeling_task]
    end

    test "get_labeling_task!/1 returns the labeling_task with given id" do
      labeling_task = labeling_task_fixture()
      assert LabelingTasks.get_labeling_task!(labeling_task.id) == labeling_task
    end

    test "create_labeling_task/1 with valid data creates a labeling_task" do
      assert {:ok, %LabelingTask{} = labeling_task} =
               LabelingTasks.create_labeling_task(@valid_attrs)

      assert labeling_task.due_date == ~N[2010-04-17 14:00:00.000000]
      assert labeling_task.due_labels == 42
    end

    test "create_labeling_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LabelingTasks.create_labeling_task(@invalid_attrs)
    end

    test "update_labeling_task/2 with valid data updates the labeling_task" do
      labeling_task = labeling_task_fixture()

      assert {:ok, labeling_task} =
               LabelingTasks.update_labeling_task(labeling_task, @update_attrs)

      assert %LabelingTask{} = labeling_task
      assert labeling_task.due_date == ~N[2011-05-18 15:01:01.000000]
      assert labeling_task.due_labels == 43
    end

    test "update_labeling_task/2 with invalid data returns error changeset" do
      labeling_task = labeling_task_fixture()

      assert {:error, %Ecto.Changeset{}} =
               LabelingTasks.update_labeling_task(labeling_task, @invalid_attrs)

      assert labeling_task == LabelingTasks.get_labeling_task!(labeling_task.id)
    end

    test "delete_labeling_task/1 deletes the labeling_task" do
      labeling_task = labeling_task_fixture()
      assert {:ok, %LabelingTask{}} = LabelingTasks.delete_labeling_task(labeling_task)

      assert_raise Ecto.NoResultsError, fn ->
        LabelingTasks.get_labeling_task!(labeling_task.id)
      end
    end

    test "change_labeling_task/1 returns a labeling_task changeset" do
      labeling_task = labeling_task_fixture()
      assert %Ecto.Changeset{} = LabelingTasks.change_labeling_task(labeling_task)
    end
  end
end
