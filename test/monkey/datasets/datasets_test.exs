defmodule Monkey.DatasetsTest do
  use Monkey.DataCase

  alias Monkey.Datasets
  alias Monkey.Accounts

  describe "datasets" do
    alias Monkey.Datasets.Dataset

    def user_factory do
      {:ok, user} =
        Accounts.create_user(%{
          username: "username",
          name: "name",
          email: "example@email.com",
          password: "password"
        })

      user
    end

    @valid_attrs %{
      description: "some description",
      is_archived: true,
      is_private: true,
      license: "some license",
      name: "some name",
      tag_list: [],
      thumbnail_url: "some thumbnail_url",
      data_type_id: 1,
      label_type_id: 1
    }
    @update_attrs %{
      description: "some updated description",
      is_archived: false,
      is_private: false,
      license: "some updated license",
      name: "some updated name",
      tag_list: [],
      thumbnail_url: "some updated thumbnail_url"
    }
    @invalid_attrs %{
      user_owner_id: nil,
      data_type_id: nil,
      label_type_id: nil,
      label_definition_id: nil,
      name: nil
    }

    def dataset_fixture(attrs \\ %{}) do
      user = user_factory()

      dataset_attrs =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.put(:user_owner_id, user.id)

      {:ok, dataset} = Datasets.create_dataset(dataset_attrs)

      dataset
    end

    test "list_datasets/0 returns all datasets" do
      dataset = dataset_fixture()
      assert Datasets.list_datasets() == [dataset]
    end

    test "get_dataset!/1 returns the dataset with given id" do
      dataset = dataset_fixture()
      assert Datasets.get_dataset!(dataset.id) == dataset
    end

    test "create_dataset/1 with valid data creates a dataset" do
      dataset = dataset_fixture()
      assert dataset.description == "some description"
      assert dataset.is_archived == true
      assert dataset.is_private == true
      assert dataset.license == "some license"
      assert dataset.name == "some name"
      assert dataset.tag_list == []
      assert dataset.thumbnail_url == "some thumbnail_url"
    end

    test "create_dataset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Datasets.create_dataset(@invalid_attrs)
    end

    test "update_dataset/2 with valid data updates the dataset" do
      dataset = dataset_fixture()
      assert {:ok, dataset} = Datasets.update_dataset(dataset, @update_attrs)
      assert %Dataset{} = dataset
      assert dataset.description == "some updated description"
      assert dataset.is_archived == false
      assert dataset.is_private == false
      assert dataset.license == "some updated license"
      assert dataset.name == "some updated name"
      assert dataset.tag_list == []
      assert dataset.thumbnail_url == "some updated thumbnail_url"
    end

    test "update_dataset/2 with invalid data returns error changeset" do
      dataset = dataset_fixture()
      assert {:error, %Ecto.Changeset{}} = Datasets.update_dataset(dataset, @invalid_attrs)
      assert dataset == Datasets.get_dataset!(dataset.id)
    end

    test "delete_dataset/1 deletes the dataset" do
      dataset = dataset_fixture()
      assert {:ok, %Dataset{}} = Datasets.delete_dataset(dataset)
      assert_raise Ecto.NoResultsError, fn -> Datasets.get_dataset!(dataset.id) end
    end

    test "change_dataset/1 returns a dataset changeset" do
      dataset = dataset_fixture()
      assert %Ecto.Changeset{} = Datasets.change_dataset(dataset)
    end
  end
end
