defmodule Photographer.Seeds do
  @moduledoc """
  Seeds database with initial data.
  """

  alias Photographer.Repo
  alias Photographer.Accounts.User
  alias Photographer.Galleries.Gallery
  alias Photographer.Photos.Photo
  alias Photographer.Contacts.Contact

  def run do
    # Create admin user
    admin_attrs = %{
      email: "admin@example.com",
      password: "admin123",
      password_confirmation: "admin123",
      role: "admin"
    }

    case Photographer.Accounts.create_user(admin_attrs) do
      {:ok, _user} -> IO.puts("✓ Admin user created")
      {:error, _changeset} -> IO.puts("⚠ Admin user already exists")
    end

    # Create sample galleries
    gallery_attrs = [
      %{name: "Весільна фотографія", slug: "wedding", description: "Красиві моменти весілля"},
      %{name: "Портрети", slug: "portraits", description: "Студійні та вуличні портрети"},
      %{name: "Природа", slug: "nature", description: "Пейзажі та природа України"}
    ]

    Enum.each(gallery_attrs, fn attrs ->
      case Photographer.Galleries.create_gallery(attrs) do
        {:ok, _gallery} -> IO.puts("✓ Gallery created: #{attrs.name}")
        {:error, _changeset} -> IO.puts("⚠ Gallery exists: #{attrs.name}")
      end
    end)

    IO.puts("✓ Seeds completed!")
  end
end
