defmodule Photographer.Photos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :title, :string
    field :url, :string
    field :description, :string
    field :file_path, :string
    field :file_size, :integer
    field :mime_type, :string
    field :width, :integer
    field :height, :integer
    field :is_published, :boolean, default: true

    many_to_many :galleries, Photographer.Galleries.Gallery,
      join_through: "photo_galleries",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:title, :url, :description, :file_path, :file_size, :mime_type, :width, :height, :is_published])
    |> validate_required([:title, :url])
    |> validate_length(:title, min: 2, max: 255)
    |> validate_length(:description, max: 1000)
    |> validate_inclusion(:mime_type, ["image/jpeg", "image/png", "image/gif", "image/webp"])
  end
end
