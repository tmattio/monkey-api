defmodule MonkeyWeb.Resolvers.Account do
  import Ecto.Query, only: [where: 2]

  alias Monkey.Repo
  alias Monkey.Accounts.User

  def update_user(%{id: id, user: user_params}, _info) do
    Repo.get!(User, id)
    |> User.changeset(user_params)
    |> Repo.update()
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
    {:ok, nil}
  end
end
