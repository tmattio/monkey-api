defmodule MonkeyWeb.Schema.Query.AccountsTest do
  use MonkeyWeb.ConnCase, async: true

  alias Monkey.Accounts.{User, Organization}

  @query """
  """
  test "createDatapoint when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "createDatapoint without the rights returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "createDatapoint with invalid image returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "createDatapoint with valid image creates a datapoint" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteDatapoint when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteDatapoint without the rights returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteDatapoint with invalid datapoint returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "deleteDatapoint with valid datapoint deletes the datapoint" do
    # TODO(tmattio): Implement
  end
end
