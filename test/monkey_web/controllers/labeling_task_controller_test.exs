defmodule MonkeyWeb.LabelingTaskControllerTest do
  use MonkeyWeb.ConnCase

  alias Monkey.LabelingTasks
  alias Monkey.LabelingTasks.LabelingTask

  @create_attrs %{due_date: ~N[2010-04-17 14:00:00.000000], due_labels: 42}
  @update_attrs %{due_date: ~N[2011-05-18 15:01:01.000000], due_labels: 43}
  @invalid_attrs %{due_date: nil, due_labels: nil}

  def fixture(:labeling_task) do
    {:ok, labeling_task} = LabelingTasks.create_labeling_task(@create_attrs)
    labeling_task
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all labeling_tasks", %{conn: conn} do
      conn = get(conn, labeling_task_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create labeling_task" do
    test "renders labeling_task when data is valid", %{conn: conn} do
      conn = post(conn, labeling_task_path(conn, :create), labeling_task: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, labeling_task_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "due_date" => ~N[2010-04-17 14:00:00.000000],
               "due_labels" => 42
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, labeling_task_path(conn, :create), labeling_task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update labeling_task" do
    setup [:create_labeling_task]

    test "renders labeling_task when data is valid", %{
      conn: conn,
      labeling_task: %LabelingTask{id: id} = labeling_task
    } do
      conn =
        put(conn, labeling_task_path(conn, :update, labeling_task), labeling_task: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, labeling_task_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "due_date" => ~N[2011-05-18 15:01:01.000000],
               "due_labels" => 43
             }
    end

    test "renders errors when data is invalid", %{conn: conn, labeling_task: labeling_task} do
      conn =
        put(conn, labeling_task_path(conn, :update, labeling_task), labeling_task: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete labeling_task" do
    setup [:create_labeling_task]

    test "deletes chosen labeling_task", %{conn: conn, labeling_task: labeling_task} do
      conn = delete(conn, labeling_task_path(conn, :delete, labeling_task))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, labeling_task_path(conn, :show, labeling_task))
      end)
    end
  end

  defp create_labeling_task(_) do
    labeling_task = fixture(:labeling_task)
    {:ok, labeling_task: labeling_task}
  end
end
