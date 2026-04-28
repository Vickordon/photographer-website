defmodule Photographer.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :name, :string
    field :email, :string
    field :phone, :string
    field :message, :string
    field :is_read, :boolean, default: false
    field :replied_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:name, :email, :phone, :message, :is_read, :replied_at])
    |> validate_required([:name, :email, :message])
    |> validate_length(:name, min: 2, max: 255)
    |> validate_length(:message, min: 10, max: 2000)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 255)
  end
end
