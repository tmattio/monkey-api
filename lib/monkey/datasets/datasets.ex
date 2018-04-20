defmodule Monkey.Datasets do
  @moduledoc """
  The Datasets context.
  """

  import Ecto.Query, warn: false
  alias Monkey.Repo

  alias Monkey.Datasets.Dataset
  alias Monkey.Labels
  alias Monkey.Datapoints

  @doc """
  Returns the list of datasets.

  ## Examples

      iex> list_datasets()
      [%Dataset{}, ...]

  """
  def list_datasets do
    Repo.all(Dataset)
  end

  @doc """
  Gets a single dataset.

  Raises `Ecto.NoResultsError` if the Dataset does not exist.

  ## Examples

      iex> get_dataset!(123)
      %Dataset{}

      iex> get_dataset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dataset!(id), do: Repo.get!(Dataset, id)

  @doc """
  Creates a dataset.

  ## Examples

      iex> create_dataset(%{field: value})
      {:ok, %Dataset{}}

      iex> create_dataset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dataset(attrs \\ %{}) do
    %Dataset{}
    |> Dataset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dataset.

  ## Examples

      iex> update_dataset(dataset, %{field: new_value})
      {:ok, %Dataset{}}

      iex> update_dataset(dataset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dataset(%Dataset{} = dataset, attrs) do
    dataset
    |> Dataset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Dataset.

  ## Examples

      iex> delete_dataset(dataset)
      {:ok, %Dataset{}}

      iex> delete_dataset(dataset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dataset(%Dataset{} = dataset) do
    Repo.delete(dataset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dataset changes.

  ## Examples

      iex> change_dataset(dataset)
      %Ecto.Changeset{source: %Dataset{}}

  """
  def change_dataset(%Dataset{} = dataset) do
    Dataset.changeset(dataset, %{})
  end

  @doc """
  Gets a single dataset.

  ## Examples

      iex> get_dataset("monkey-user", "dataset-name")
      %Dataset{}

  """
  def get_dataset(owner, name) do
    Repo.one(
      from(
        d in Dataset,
        join: u in assoc(d, :user_owner),
        where: u.username == ^owner and d.slug == ^name,
        preload: [:data_type, :label_type, user_owner: u]
      )
    )
  end

  def get_dataset!(owner, name) do
    Repo.one!(
      from(
        d in Dataset,
        join: u in assoc(d, :user_owner),
        where: u.username == ^owner and d.slug == ^name,
        preload: [:data_type, :label_type, :user_owner]
      )
    )
  end

  @search [Dataset]
  def search_datasets(term) do
    pattern = "%#{term}%"
    Enum.flat_map(@search, &search_ecto(&1, pattern))
  end

  defp search_ecto(ecto_schema, pattern) do
    Repo.all(
      from(
        q in ecto_schema,
        where:
          (ilike(q.name, ^pattern) or ilike(q.description, ^pattern)) and q.is_private == false
      )
    )
  end

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end

  def export_dataset(dataset) do
    data_type = Datapoints.data_type_from_name(dataset.data_type.name)
    {label_type, _label_def} = Labels.label_type_from_name(dataset.label_type.name)

    datapoints_to_labels =
      from(
        d in data_type,
        where: d.dataset_id == ^dataset.id,
        join: l in ^label_type,
        on: l.dataset_id == ^dataset.id and l.datapoint_id == d.id,
        select: {d, l}
      )
      |> Repo.all()
      |> Enum.map(fn {d, l} ->
        %{
          datapoint: d,
          label: l
        }
      end)

    content = Poison.encode!(datapoints_to_labels)
    filename = dataset.user_owner.username <> "-" <> dataset.slug <> ".json"
    File.write!("exported_datasets/" <> filename, content, [:write])
    filename
  end
end
