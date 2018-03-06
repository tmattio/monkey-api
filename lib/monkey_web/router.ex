defmodule MonkeyWeb.Router do
  use MonkeyWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", MonkeyWeb do
    pipe_through(:api)

    resources("/organizations", OrganizationController, except: [:new, :edit])
    resources("/users", UserController, except: [:new, :edit])
    resources("/datasets", DatasetController, except: [:new, :edit])
    resources("/labeling_tasks", LabelingTaskController, except: [:new, :edit])
  end
end
