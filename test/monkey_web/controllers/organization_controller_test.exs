defmodule MonkeyWeb.OrganizationControllerTest do
  use MonkeyWeb.ConnCase

  alias Monkey.Accounts
  alias Monkey.Accounts.Organization

  @create_attrs %{
    avatar_url: "some avatar_url",
    billing_email: "some billing_email",
    description: "some description",
    email: "some email",
    is_active: true,
    name: "some name",
    website_url: "some website_url"
  }
  @update_attrs %{
    avatar_url: "some updated avatar_url",
    billing_email: "some updated billing_email",
    description: "some updated description",
    email: "some updated email",
    is_active: false,
    name: "some updated name",
    website_url: "some updated website_url"
  }
  @invalid_attrs %{
    avatar_url: nil,
    billing_email: nil,
    description: nil,
    email: nil,
    is_active: nil,
    name: nil,
    website_url: nil
  }

  def fixture(:organization) do
    {:ok, organization} = Accounts.create_organization(@create_attrs)
    organization
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all organizations", %{conn: conn} do
      conn = get(conn, organization_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create organization" do
    test "renders organization when data is valid", %{conn: conn} do
      conn = post(conn, organization_path(conn, :create), organization: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, organization_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "avatar_url" => "some avatar_url",
               "billing_email" => "some billing_email",
               "description" => "some description",
               "email" => "some email",
               "is_active" => true,
               "name" => "some name",
               "website_url" => "some website_url"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, organization_path(conn, :create), organization: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update organization" do
    setup [:create_organization]

    test "renders organization when data is valid", %{
      conn: conn,
      organization: %Organization{id: id} = organization
    } do
      conn =
        put(conn, organization_path(conn, :update, organization), organization: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, organization_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "avatar_url" => "some updated avatar_url",
               "billing_email" => "some updated billing_email",
               "description" => "some updated description",
               "email" => "some updated email",
               "is_active" => false,
               "name" => "some updated name",
               "website_url" => "some updated website_url"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, organization: organization} do
      conn =
        put(conn, organization_path(conn, :update, organization), organization: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete organization" do
    setup [:create_organization]

    test "deletes chosen organization", %{conn: conn, organization: organization} do
      conn = delete(conn, organization_path(conn, :delete, organization))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, organization_path(conn, :show, organization))
      end)
    end
  end

  defp create_organization(_) do
    organization = fixture(:organization)
    {:ok, organization: organization}
  end
end
