defmodule FakeInternet.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FakeInternet.Accounts.User


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :is_admin, :boolean, default: false
    field :is_teacher, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password, :is_teacher, :is_admin])
    |> validate_required([:email, :encrypted_password, :is_teacher, :is_admin])
  end
end
