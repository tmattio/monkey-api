defmodule Monkey.Factory do
  use ExMachina.Ecto, repo: Monkey.Repo

  def organization_factory do
    %Monkey.Accounts.Organization{
      name: sequence(:name, &"Organization #{&1}"),
      billing_email: sequence(:billing_email, &"billing-#{&1}@example.com")
    }
  end

  def user_factory do
    %Monkey.Accounts.User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "password",
      username: "jsmith",
      bio: "I am a very ordinary person.",
      organization: build(:organization)
    }
  end

  def dataset_factory do
    data_type = Monkey.Repo.get_by(Monkey.Datapoints.DataType, name: "Image")
    label_type = Monkey.Repo.get_by(Monkey.Labels.LabelType, name: "Image Classification")

    %Monkey.Datasets.Dataset{
      name: sequence(:name, &"Dataset #{&1}"),
      description: "A collection of images of cats and dogs.",
      data_type: data_type,
      label_type: label_type,
      user_owner: build(:user),
      company_owner: build(:organization),
      is_private: false,
    }
  end
end
