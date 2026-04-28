defmodule Photographer.Photos do
  @moduledoc """
  Photos context - manages photo gallery functionality
  """

  import Ecto.Query, warn: false
  alias Photographer.Repo
  alias Photographer.Photos.Photo

  def list_photos(filters \\ []), do: Photo |> apply_filters(filters) |> Repo.all()
  def get_photo!(id), do: Repo.get!(Photo, id)

  def create_photo(attrs \\ %{}) do
    %Photo{} |> Photo.changeset(attrs) |> Repo.insert()
  end

  def update_photo(%Photo{} = photo, attrs) do
    photo |> Photo.changeset(attrs) |> Repo.update()
  end

  def delete_photo(%Photo{} = photo), do: Repo.delete(photo)
  def change_photo(%Photo{} = photo, attrs \\ %{}), do: Photo.changeset(photo, attrs)

  defp apply_filters(query, %{"is_published" => is_published}) do
    where(query, [p], p.is_published == ^is_published)
  end
  defp apply_filters(query, _), do: query
end
