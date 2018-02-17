defmodule FakeInternet.Accounts do
  import Ecto.Query, warn: false
  alias FakeInternet.Repo

  alias FakeInternet.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_by_email_and_password(email, password) do
    User
    |> Repo.get_by(email: email)
    |> Comeonin.Bcrypt.check_pass(password, hash_key: :encrypted_password)
  end
end
