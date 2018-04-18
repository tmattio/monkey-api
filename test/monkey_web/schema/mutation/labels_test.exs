defmodule MonkeyWeb.Schema.Mutation.LabelsTest do
  use MonkeyWeb.ConnCase, async: true

  alias Monkey.Accounts.{User, Organization}

  @query """
  """
  test "updateLabel when logged out returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateLabel without the rights returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateLabel with invalid image class returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateLabel with valid image class update the label" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateLabel with invalid image bounding box returns an error" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateLabel with valid image bounding box update the label" do
    # TODO(tmattio): Implement
  end

  @query """
  """
  test "updateLabel with null label input deletes the datapoint labels" do
    # TODO(tmattio): Implement
  end
end
