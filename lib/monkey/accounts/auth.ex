defmodule Monkey.Accounts.Auth do
  @moduledoc """
  The boundry for the Auth system
  """

  import Ecto.{Query, Changeset}, warn: false

  alias Monkey.Repo
  alias Monkey.Accounts.User
  alias Monkey.Accounts.Encryption

  def authenticate(params) do
    user = Repo.get_by(User, username: params.username)

    case check_password(user, params.password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Encryption.validate_password(password, user.password_hash)
    end
  end
end
