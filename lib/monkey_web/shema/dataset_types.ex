defmodule MonkeyWeb.Schema.DatasetTypes do
  use Absinthe.Schema.Notation

  alias MonkeyWeb.Resolvers

  object :dataset do
    field(:id, :id)
    field(:description, :string)
    field(:is_archived, :boolean)
    field(:is_private, :boolean)
    field(:label_definition_id, :id)
    field(:license, :string)
    field(:name, :string)
    field(:tag_list, list_of(:string))
    field(:thumbnail_url, :string)
    field(:data_type, :id)
    field(:user_owner, :id)
    field(:company_owner, :id)
  end
end
