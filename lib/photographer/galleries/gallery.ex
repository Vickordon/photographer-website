defmodule Photographer.Galleries.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "galleries" do
    field :name, :string
    field :description, :string
    field :slug, :string
    field :is_published, :boolean, default: true
    field :sort_order, :integer, default: 0

    many_to_many :photos, Photographer.Photos.Photo,
      join_through: "photo_galleries",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  def changeset(gallery, attrs) do
    gallery
    |> cast(attrs, [:name, :description, :slug, :is_published, :sort_order])
    |> validate_required([:name])
    |> validate_length(:name, min: 2, max: 255)
    |> unique_constraint(:slug)
    |> generate_slug()
  end

  defp generate_slug(changeset) do
    case get_field(changeset, :slug) do
      nil ->
        name = get_field(changeset, :name)
        slug = name |> String.downcase() |> String.replace(~r/[^a-z0-9]+/, "-") |> String.trim("-")
        put_change(changeset, :slug, slug)
      _ -> changeset
    end
  end
end
