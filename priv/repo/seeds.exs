alias Photographer.Repo
alias Photographer.Accounts.User
alias Photographer.Photos.Photo
alias Photographer.Galleries.Gallery
alias Photographer.Contacts.Contact

# Create admin user
admin = %User{
  email: "admin@example.com",
  password_hash: Bcrypt.hash_pwd_salt("admin123"),
  role: "admin"
}

Repo.insert!(admin, on_conflict: :nothing)

IO.puts("✅ Admin user created: admin@example.com / admin123")

# Create sample galleries
gallery1 = %Gallery{
  name: "Весільна фотографія",
  description: "Красиві моменти весіль",
  slug: "wedding"
}

gallery2 = %Gallery{
  name: "Портрети",
  description: "Студійні та вуличні портрети",
  slug: "portraits"
}

Repo.insert!(gallery1, on_conflict: :nothing)
Repo.insert!(gallery2, on_conflict: :nothing)

IO.puts("✅ Galleries created")

IO.puts("🎉 Seeds completed!")
