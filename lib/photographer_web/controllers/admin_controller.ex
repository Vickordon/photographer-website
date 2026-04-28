defmodule PhotographerWeb.AdminController do
  use PhotographerWeb, :controller

  def index(conn, _params) do
    render(conn, :index, title: "Адмін-панель")
  end

  def photos(conn, _params) do
    photos = []
    render(conn, :photos, title: "Управління фото", photos: photos)
  end

  def upload_photo(conn, _params) do
    conn
    |> put_flash(:info, "Фото завантажено успішно!")
    |> redirect(to: ~p"/admin/photos")
  end

  def delete_photo(conn, %{"id" => _id}) do
    conn
    |> put_flash(:info, "Фото видалено!")
    |> redirect(to: ~p"/admin/photos")
  end
end
