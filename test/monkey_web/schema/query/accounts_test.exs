defmodule MonkeyWeb.Schema.Query.AccountsTest do
  use MonkeyWeb.ConnCase, async: true

  alias Monkey.Accounts.{User, Organization}


  @query """
  """
  test "viewer when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "viewer when logged in returns the current user" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "user returns a user when match" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "user does not return a user when no match" do
    # TODO(tmattio): Implement
  end
end
