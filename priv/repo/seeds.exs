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

defmodule Monkey.Seeds do
  def run() do
    alias Monkey.Repo
    alias Monkey.Datasets.{Dataset, LabelACL, LabelDefinitionACL, DataACL}
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
      dogs_and_cats_def =
        %ImageClassDefinition{classes: ["Dog", "Cat"]}
        |> Repo.insert!()

      dogs_and_cats_def_acl =
        %LabelDefinitionACL{
          label_type: image_class_label_type,
          image_class: dogs_and_cats_def
        }
        |> Repo.insert!()

      dogs_and_cats =
        %Dataset{
          name: "Dogs and Cats",
          description: "A collection of images of cats and dogs.",
          tag_list: ["Dog", "Cat"],
          data_type: image,
          label_definition: dogs_and_cats_def_acl
        }
        |> Repo.insert!()

      image_1 =
        %Image{
          compression_format: "jpeg",
          depth: 3,
          filesize: 87_032,
          height: 669,
          width: 1216,
          storage_path:
            "http://www.antenastajerska.si/media/07722f66-e459-42b7-9cdd-4013b102e7ad.jpg"
        }
        |> Repo.insert!()

      _image_1_acl =
        %DataACL{
          data_type: image,
          image: image_1,
          dataset: dogs_and_cats
        }
        |> Repo.insert!()

      image_1_label =
        %ImageClass{
          class: "Dog"
        }
        |> Repo.insert!()

      _image_1_label_acl =
        %LabelACL{
          label_type: image_class_label_type,
          image_class: image_1_label,
          dataset: dogs_and_cats
        }
        |> Repo.insert!()

      image_2 =
        %Image{
          compression_format: "jpeg",
          depth: 3,
          filesize: 3_285_366,
          height: 2304,
          width: 3456,
          storage_path:
            "https://static.pexels.com/photos/20787/pexels-photo.jpg"
        }
        |> Repo.insert!()

      _image_2_acl =
        %DataACL{
          data_type: image,
          image: image_2,
          dataset: dogs_and_cats
        }
        |> Repo.insert!()

      image_2_label =
        %ImageClass{
          class: "Cat"
        }
        |> Repo.insert!()

      _image_2_label_acl =
        %LabelACL{
          label_type: image_class_label_type,
          image_class: image_2_label,
          dataset: dogs_and_cats
        }
        |> Repo.insert!()
    end

    :ok
  end
end

Monkey.Seeds.run()
