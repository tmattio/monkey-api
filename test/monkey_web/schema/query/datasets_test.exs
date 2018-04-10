defmodule MonkeyWeb.Schema.Query.DatasetsTest do
  use MonkeyWeb.ConnCase, async: true

  alias Monkey.Datasets.Dataset

  @query """
  {
    searchDatasets(query: "") {
      name
      description
      owner {
        name
      }
    }
  }
  """
  test "searchDatasets returns datasets" do
    conn = build_conn()

    dataset =
      %Dataset{}
      |> Dataset.changeset(params_with_assocs(:dataset))
      |> Monkey.Repo.insert!()

    user = Ecto.assoc(dataset, :user_owner) |> Monkey.Repo.one!()

    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "searchDatasets" => [
                 %{
                   "name" => dataset.name,
                   "description" => dataset.description,
                   "owner" => %{
                     "name" => user.name
                   }
                 }
               ]
             }
           }
  end

  @query """
  query ($datasetName: String) {
    dataset(owner: "jsmith", name: $datasetName) {
      name
      dataType {
        name
      }
      labelType {
        name
      }
      labelDefinition {
        __typename
      }
    }
  }
  """
  test "dataset returns a dataset when match" do
    conn = build_conn()

    dataset =
      %Dataset{}
      |> Dataset.changeset(params_with_assocs(:dataset))
      |> Monkey.Repo.insert!()

    conn =
      get(
        conn,
        "/api",
        query: @query,
        variables: %{"datasetName" => dataset.slug}
      )

    assert json_response(conn, 200) == %{
             "data" => %{
               "dataset" => %{"name" => dataset.name}
             }
           }
  end

  @query """
  {
    dataset(owner: "jsmith", name: "non-existent") {
      name
    }
  }
  """
  test "dataset does not return a dataset when no match" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "dataset" => %{}
             }
           }
  end

  @query """
  {
    dataTypes {
      name
    }
  }
  """
  test "dataTypes returns the data types" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "dataTypes" => [
                 %{"name" => "Image"},
                 %{"name" => "Text"},
                 %{"name" => "Video"},
                 %{"name" => "Audio"}
               ]
             }
           }
  end

  @query """
  {
    labelTypes {
      name
    }
  }
  """
  test "labelTypes returns the label types" do
    conn = build_conn()
    conn = get(conn, "/api", query: @query)

    assert json_response(conn, 200) == %{
             "data" => %{
               "labelTypes" => [
                 %{"name" => "Image Classification"},
                 %{"name" => "Image Object Detection"}
               ]
             }
           }
  end
end
