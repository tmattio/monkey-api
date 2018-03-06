defmodule MonkeyWeb.OrganizationView do
  use MonkeyWeb, :view
  alias MonkeyWeb.OrganizationView

  def render("index.json", %{organizations: organizations}) do
    %{data: render_many(organizations, OrganizationView, "organization.json")}
  end

  def render("show.json", %{organization: organization}) do
    %{data: render_one(organization, OrganizationView, "organization.json")}
  end

  def render("organization.json", %{organization: organization}) do
    %{
      id: organization.id,
      avatar_url: organization.avatar_url,
      description: organization.description,
      email: organization.email,
      billing_email: organization.billing_email,
      name: organization.name,
      website_url: organization.website_url,
      is_active: organization.is_active
    }
  end
end
