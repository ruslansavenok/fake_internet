defmodule FakeInternet.Questions.Question do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias FakeInternet.Questions.Question


  schema "questions" do
    field :question, :string
    field :category_id, :id
    field :image, FakeInternet.QuestionImage.Type

    timestamps()
  end

  @doc false
  def changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, [:question, :category_id])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:question])
  end
end
