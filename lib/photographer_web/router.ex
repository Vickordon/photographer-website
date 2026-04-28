defmodule PhotographerWeb.Router do
  use PhotographerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhotographerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhotographerWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/portfolio", PageController, :portfolio
    get "/about", PageController, :about
    get "/contact", PageController, :contact
    post "/contact", PageController, :submit_contact
  end

  scope "/admin", PhotographerWeb do
    pipe_through :browser

    get "/", AdminController, :index
    get "/photos", AdminController, :photos
    post "/photos/upload", AdminController, :upload_photo
    delete "/photos/:id", AdminController, :delete_photo
  end
end
