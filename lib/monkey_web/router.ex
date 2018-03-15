defmodule MonkeyWeb.Router do
  use MonkeyWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api" do
    pipe_through(:api)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: MonkeyWeb.Schema)
    forward("/", Absinthe.Plug, schema: MonkeyWeb.Schema)
  end
end
