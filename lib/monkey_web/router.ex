defmodule MonkeyWeb.Router do
  use MonkeyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MonkeyWeb do
    pipe_through :api
  end
end
