defmodule MonkeyWeb.Auth.BearerAuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :monkey,
    module: MonkeyWeb.Guardian,
    error_handler: MonkeyWeb.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
  plug(Guardian.Plug.LoadResource)
end
