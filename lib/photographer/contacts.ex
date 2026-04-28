defmodule Photographer.Contacts do
  @moduledoc """
  Contacts context - manages contact form submissions
  """

  import Ecto.Query, warn: false
  alias Photographer.Repo
  alias Photographer.Contacts.Contact

  def list_contacts(filters \\ []) do
    Contact |> apply_filters(filters) |> order_by([c], desc: c.inserted_at) |> Repo.all()
  end

  def get_contact!(id), do: Repo.get!(Contact, id)

  def create_contact(attrs \\ %{}) do
    %Contact{} |> Contact.changeset(attrs) |> Repo.insert()
  end

  def update_contact(%Contact{} = contact, attrs) do
    contact |> Contact.changeset(attrs) |> Repo.update()
  end

  def delete_contact(%Contact{} = contact), do: Repo.delete(contact)

  def mark_as_read(%Contact{} = contact) do
    contact |> Contact.changeset(%{is_read: true}) |> Repo.update()
  end

  def change_contact(%Contact{} = contact, attrs \\ %{}), do: Contact.changeset(contact, attrs)

  def count_unread do
    from(c in Contact, where: c.is_read == false, select: count(c.id)) |> Repo.one()
  end

  defp apply_filters(query, %{"is_read" => is_read}) do
    where(query, [c], c.is_read == ^is_read)
  end
  defp apply_filters(query, _), do: query
end
