# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Monkey.Repo.insert!(%Monkey.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`

alias Monkey.Repo
alias Monkey.Labels.{LabelType, ImageClass, ImageClassDefinition}
alias Monkey.Datapoints.{DataType, Image}

#
# DATA TYPE
#
image =
  %DataType{name: "Image"}
  |> Repo.insert!()

_text =
  %DataType{name: "Text"}
  |> Repo.insert!()

_video =
  %DataType{name: "Video"}
  |> Repo.insert!()

_audio =
  %DataType{name: "Audio"}
  |> Repo.insert!()

#
# LABEL TYPE
#
image_class_label_type =
  %LabelType{name: "Image Classification", data_type: image}
  |> Repo.insert!()

_image_bounding_box_label_type =
  %LabelType{name: "Image Object Detection", data_type: image}
  |> Repo.insert!()

if Mix.env() == :dev do
  #
  # USERS
  #
  {:ok, organization} =
    Monkey.Accounts.create_organization(%{
      avatar_url:
        "https://avatars3.githubusercontent.com/u/34143893?s=400&u=743d0834bdd76d8668fa4870003ade9882c8779c&v=4",
      billing_email: "thibaut.mattio@gmail.com",
      description: "We're building the future of AI",
      email: "thibaut.mattio@gmail.com",
      name: "Monkey Inc.",
      website_url: "https://github.com/monkey-ai"
    })

  {:ok, user} =
    Monkey.Accounts.create_user(%{
      avatar_url:
        "https://avatars0.githubusercontent.com/u/6162008?s=400&u=a95c6e6963b9016f1b808e92e845ae4a527c9455&v=4",
      bio: "I am a rockstar.",
      company: "Monkey Inc.",
      email: "thibaut.mattio@gmail.com",
      password: "password",
      username: "tmattio",
      name: "Thibaut Mattio",
      website_url: "https://tmattio.github.io/",
      organization_id: organization.id
    })

  {:ok, dataset} =
    Monkey.Datasets.create_dataset(%{
      name: "Dogs and Cats",
      description: "A collection of images of cats and dogs.",
      tag_list: ["Dog", "Cat"],
      data_type_id: image.id,
      label_type_id: image_class_label_type.id,
      user_owner_id: user.id,
      company_owner_id: organization.id
    })

  dogs_and_cats_def =
    %ImageClassDefinition{
      label_type: image_class_label_type,
      classes: ["Dog", "Cat"],
      dataset: dataset
    }
    |> Repo.insert!()

  image_1 =
    %Image{
      compression_format: "jpeg",
      depth: 3,
      filesize: 87_032,
      height: 669,
      width: 1216,
      storage_path: "http://www.antenastajerska.si/media/07722f66-e459-42b7-9cdd-4013b102e7ad.jpg",
      dataset: dataset
    }
    |> Repo.insert!()

  _image_1_label =
    %ImageClass{
      class: "Dog",
      dataset: dataset,
      datapoint: image_1
    }
    |> Repo.insert!()

  image_2 =
    %Image{
      compression_format: "jpeg",
      depth: 3,
      filesize: 3_285_366,
      height: 2304,
      width: 3456,
      storage_path: "https://static.pexels.com/photos/20787/pexels-photo.jpg",
      dataset: dataset
    }
    |> Repo.insert!()

  _image_2_label =
    %ImageClass{
      class: "Cat",
      dataset: dataset,
      datapoint: image_2
    }
    |> Repo.insert!()
end
