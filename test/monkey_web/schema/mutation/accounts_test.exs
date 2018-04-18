defmodule MonkeyWeb.Schema.Mutation.AccountsTest do
  use MonkeyWeb.ConnCase, async: true

  alias Monkey.Accounts.{User, Organization}

  @query """
  """
  test "updateViewer when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateViewer with valid input updates the viewer" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateViewer with invalid input returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteViewer when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteViewer when logged in deletes the viewer account" do
    # TODO(tmattio): Implement
  end
end
