defmodule Monkey.DatasetsTest do
  use Monkey.DataCase

  alias Monkey.Datasets

  describe "datasets" do
    alias Monkey.Datasets.Dataset

    @valid_attrs %{
      description: "some description",
      is_archived: true,
      is_private: true,
      label_definition_id: "some label_definition_id",
      license: "some license",
      name: "some name",
      tag_list: [],
      thumbnail_url: "some thumbnail_url"
    }
    @update_attrs %{
      description: "some updated description",
      is_archived: false,
      is_private: false,
      label_definition_id: "some updated label_definition_id",
      license: "some updated license",
      name: "some updated name",
      tag_list: [],
      thumbnail_url: "some updated thumbnail_url"
    }
    @invalid_attrs %{
      description: nil,
      is_archived: nil,
      is_private: nil,
      label_definition_id: nil,
      license: nil,
      name: nil,
      tag_list: nil,
      thumbnail_url: nil
    }

    def dataset_fixture(attrs \\ %{}) do
      {:ok, dataset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Datasets.create_dataset()

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
      assert {:ok, %Dataset{} = dataset} = Datasets.create_dataset(@valid_attrs)
      assert dataset.description == "some description"
      assert dataset.is_archived == true
      assert dataset.is_private == true
      assert dataset.label_definition_id == "some label_definition_id"
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
      assert dataset.label_definition_id == "some updated label_definition_id"
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
