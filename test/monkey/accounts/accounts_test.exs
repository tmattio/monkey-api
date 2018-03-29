defmodule Monkey.AccountsTest do
  use Monkey.DataCase

  alias Monkey.Accounts

  describe "organizations" do
    alias Monkey.Accounts.Organization

    @valid_attrs %{
      avatar_url: "some avatar_url",
      billing_email: "some billing_email",
      description: "some description",
      email: "some email",
      is_active: true,
      name: "some name",
      website_url: "some website_url"
    }
    @update_attrs %{
      avatar_url: "some updated avatar_url",
      billing_email: "some updated billing_email",
      description: "some updated description",
      email: "some updated email",
      is_active: false,
      name: "some updated name",
      website_url: "some updated website_url"
    }
    @invalid_attrs %{
      email: nil,
      name: nil
    }

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Accounts.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Accounts.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Accounts.create_organization(@valid_attrs)
      assert organization.avatar_url == "some avatar_url"
      assert organization.billing_email == "some billing_email"
      assert organization.description == "some description"
      assert organization.email == "some email"
      assert organization.is_active == true
      assert organization.name == "some name"
      assert organization.website_url == "some website_url"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, organization} = Accounts.update_organization(organization, @update_attrs)
      assert %Organization{} = organization
      assert organization.avatar_url == "some updated avatar_url"
      assert organization.billing_email == "some updated billing_email"
      assert organization.description == "some updated description"
      assert organization.email == "some updated email"
      assert organization.is_active == false
      assert organization.name == "some updated name"
      assert organization.website_url == "some updated website_url"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_organization(organization, @invalid_attrs)

      assert organization == Accounts.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Accounts.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Accounts.change_organization(organization)
    end
  end

  describe "users" do
    alias Monkey.Accounts.User

    @valid_attrs %{
      name: "some name",
      avatar_url: "some avatar_url",
      bio: "some bio",
      company: "some company",
      email: "some email",
      is_active: true,
      last_login: ~N[2010-04-17 14:00:00.000000],
      password: "some password",
      username: "some username",
      website_url: "some website_url"
    }
    @update_attrs %{
      name: "some updated name",
      avatar_url: "some updated avatar_url",
      bio: "some updated bio",
      company: "some updated company",
      email: "some updated email",
      is_active: false,
      last_login: ~N[2011-05-18 15:01:01.000000],
      password: "some updated password",
      username: "some updated username",
      website_url: "some updated website_url"
    }
    @invalid_attrs %{
      avatar_url: nil,
      bio: nil,
      company: nil,
      email: nil,
      is_active: nil,
      last_login: nil,
      password: nil,
      username: nil,
      website_url: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      user_list = Enum.map(Accounts.list_users(), &Map.delete(&1, :password))
      assert user_list == [Map.delete(user, :password)]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) |> Map.delete(:password) == user |> Map.delete(:password)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar_url == "some avatar_url"
      assert user.bio == "some bio"
      assert user.company == "some company"
      assert user.email == "some email"
      assert user.is_active == true
      assert user.last_login == ~N[2010-04-17 14:00:00.000000]
      assert user.username == "some username"
      assert user.website_url == "some website_url"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.avatar_url == "some updated avatar_url"
      assert user.bio == "some updated bio"
      assert user.company == "some updated company"
      assert user.email == "some updated email"
      assert user.is_active == false
      assert user.last_login == ~N[2011-05-18 15:01:01.000000]
      assert user.username == "some updated username"
      assert user.website_url == "some updated website_url"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user |> Map.delete(:password) == Accounts.get_user!(user.id) |> Map.delete(:password)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
