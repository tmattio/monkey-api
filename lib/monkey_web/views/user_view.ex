defmodule MonkeyWeb.UserView do
  use MonkeyWeb, :view
  alias MonkeyWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      password: user.password,
      username: user.username,
      bio: user.bio,
      avatar_url: user.avatar_url,
      website_url: user.website_url,
      company: user.company,
      last_login: user.last_login,
      is_active: user.is_active
    }
  end
end
