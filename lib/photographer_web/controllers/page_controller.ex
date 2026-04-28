defmodule PhotographerWeb.PageController do
  use PhotographerWeb, :controller

  def home(conn, _params) do
    render(conn, :home, title: "Головна - Фотограф")
  end

  def portfolio(conn, _params) do
    photos = [
      %{id: 1, title: "Весільна фотографія", url: "/images/photo1.jpg"},
      %{id: 2, title: "Портретна зйомка", url: "/images/photo2.jpg"},
      %{id: 3, title: "Студійне фото", url: "/images/photo3.jpg"},
      %{id: 4, title: "Природна фотографія", url: "/images/photo4.jpg"},
      %{id: 5, title: "Міська фотографія", url: "/images/photo5.jpg"},
      %{id: 6, title: "Сімейна фотосесія", url: "/images/photo6.jpg"}
    ]
    render(conn, :portfolio, title: "Портфоліо - Фотограф", photos: photos)
  end

  def about(conn, _params) do
    render(conn, :about, title: "Про мене - Фотограф")
  end

  def contact(conn, _params) do
    render(conn, :contact, title: "Контакти - Фотограф")
  end

  def submit_contact(conn, %{"contact" => _contact_params}) do
    conn
    |> put_flash(:info, "Дякуємо! Ваше повідомлення надіслано.")
    |> redirect(to: ~p"/contact")
  end
end
