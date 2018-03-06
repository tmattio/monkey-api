defmodule MonkeyWeb.UserControllerTest do
  use MonkeyWeb.ConnCase

  alias Monkey.Accounts
  alias Monkey.Accounts.User

  @create_attrs %{
    avatar_url: "some avatar_url",
    bio: "some bio",
    company: "some company",
    email: "some email",
    is_active: true,
    last_login: ~N[2010-04-17 14:00:00.000000],
    password: "some password",
    username: "some username",
    website_url: "some website_url"
  }
  @update_attrs %{
    avatar_url: "some updated avatar_url",
    bio: "some updated bio",
    company: "some updated company",
    email: "some updated email",
    is_active: false,
    last_login: ~N[2011-05-18 15:01:01.000000],
    password: "some updated password",
    username: "some updated username",
    website_url: "some updated website_url"
  }
  @invalid_attrs %{
    avatar_url: nil,
    bio: nil,
    company: nil,
    email: nil,
    is_active: nil,
    last_login: nil,
    password: nil,
    username: nil,
    website_url: nil
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "avatar_url" => "some avatar_url",
               "bio" => "some bio",
               "company" => "some company",
               "email" => "some email",
               "is_active" => true,
               "last_login" => ~N[2010-04-17 14:00:00.000000],
               "password" => "some password",
               "username" => "some username",
               "website_url" => "some website_url"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "avatar_url" => "some updated avatar_url",
               "bio" => "some updated bio",
               "company" => "some updated company",
               "email" => "some updated email",
               "is_active" => false,
               "last_login" => ~N[2011-05-18 15:01:01.000000],
               "password" => "some updated password",
               "username" => "some updated username",
               "website_url" => "some updated website_url"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, user_path(conn, :show, user))
      end)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
