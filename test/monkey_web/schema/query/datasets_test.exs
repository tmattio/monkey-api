defmodule MonkeyWeb.Schema.Query.DatasetsTest do
  use MonkeyWeb.ConnCase, async: true

  @query """
  {
    searchDatasets(query:"") {
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
