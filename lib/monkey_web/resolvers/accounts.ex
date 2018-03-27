defmodule MonkeyWeb.Resolvers.Accounts do
  import Ecto.Query, only: [where: 2]

  alias Monkey.Repo
  alias Monkey.Accounts
  alias Monkey.Accounts.User

  def get_user(%{username: username}, _info) do
    user = Repo.get_by(User, username: username)
    {:ok, user}
  end

  def update_user(%{id: id, user: user_params}, _info) do
    Repo.get!(User, id)
    |> User.changeset(user_params)
    |> Repo.update()
  end

  def register(_, %{context: %{current_user: _current_user}}) do
    {:error, "You are already authenticated."}
  end

  def register(params, _info) do
    Accounts.create_user(params)
  end

  def login(_, %{context: %{current_user: _current_user}}) do
    {:error, "You are already authenticated."}
  end

  def login(params, _info) do
    with {:ok, user} <- Monkey.Accounts.Auth.authenticate(params),
         {:ok, jwt, _full_claims} <- MonkeyWeb.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    end
  end

  def viewer(_, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def viewer(_, _) do
    {:error, "You are not authenticated."}
  end
end
