defmodule MonkeyWeb.Schema.Mutation.DatasetsTest do
  use MonkeyWeb.ConnCase, async: true

  alias Monkey.Accounts.{User, Organization}

  @query """
  """
  test "createDataset when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "createDataset with valid input updates the viewer" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "createDataset with invalid input returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateDataset when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateDataset with valid input updates the viewer" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateDataset with invalid input returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteDataset when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteDataset when logged in deletes the dataset" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteDataset with with non-existing dataset returns an error" do
    # TODO(tmattio): Implement
  end
end
