defmodule MonkeyWeb.Router do
  use MonkeyWeb, :router

  pipeline :allow_cors do
    plug(CORSPlug)
  end

  pipeline :current_user do
    plug(MonkeyWeb.Plug.Context)
  end

  pipeline :bearer_auth do
    plug(MonkeyWeb.Auth.BearerAuthPipeline)
  end

  scope "/api" do
    pipe_through([:allow_cors, :bearer_auth, :current_user])

    forward("/", Absinthe.Plug, schema: MonkeyWeb.Schema)
  end

  forward("/graphiql", Absinthe.Plug.GraphiQL, schema: MonkeyWeb.Schema)
end
