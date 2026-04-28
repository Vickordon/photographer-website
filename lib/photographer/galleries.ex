defmodule Photographer.Galleries do
  @moduledoc """
  Galleries context - manages photo galleries
  """

  import Ecto.Query, warn: false
  alias Photographer.Repo
  alias Photographer.Galleries.Gallery
  alias Photographer.Photos.Photo

  def list_galleries(filters \\ []) do
    Gallery |> apply_filters(filters) |> order_by([g], asc: :sort_order, asc: :name) |> Repo.all()
  end

  def get_gallery!(id), do: Repo.get!(Gallery, id)
  def get_gallery_with_photos!(id), do: Repo.get!(Gallery, id) |> Repo.preload(:photos)

  def get_gallery_by_slug!(slug) do
    Repo.get_by!(Gallery, slug: slug) |> Repo.preload(:photos)
  end

  def create_gallery(attrs \\ %{}) do
    %Gallery{} |> Gallery.changeset(attrs) |> Repo.insert()
  end

  def update_gallery(%Gallery{} = gallery, attrs) do
    gallery |> Gallery.changeset(attrs) |> Repo.update()
  end

  def delete_gallery(%Gallery{} = gallery), do: Repo.delete(gallery)
  def change_gallery(%Gallery{} = gallery, attrs \\ %{}), do: Gallery.changeset(gallery, attrs)

  def add_photo_to_gallery(%Gallery{} = gallery, %Photo{} = photo) do
    gallery |> Gallery.changeset(%{photos: [photo]}) |> Repo.update()
  end

  defp apply_filters(query, %{"is_published" => is_published}) do
    where(query, [g], g.is_published == ^is_published)
  end
  defp apply_filters(query, _), do: query
end
