defmodule MonkeyWeb.Schema.Query.MenuItemsTest do
  use MonkeyWeb.ConnCase, async: true

  alias Monkey.Datasets
  alias Monkey.Datasets.Dataset

  setup do
    Monkey.Seeds.run()
  end

  @query """
  {
    menuItems {
      name
    }
  }
  """
  test "datasets field returns datasets" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "datasets" => [
                 %{"name" => "Dogs and Cats"}
               ]
             }
           }
  end
end
