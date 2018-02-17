defmodule FakeInternetWeb.QuestionController do
  use FakeInternetWeb, :controller

  alias FakeInternet.Questions
  alias FakeInternet.Questions.Question
  alias FakeInternet.Categories

  def index(conn, _params) do
    questions = Questions.list_questions()
    render(conn, "index.html", questions: questions)
  end

  def new(conn, _params) do
    changeset = Questions.change_question(%Question{})
    render(conn, "new.html",
      changeset: changeset,
      categories: Categories.list_categories()
    )
  end

  def create(conn, %{"question" => question_params}) do
    case Questions.create_question(question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: question_path(conn, :show, question))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          categories: Categories.list_categories()
        )
    end
  end

  def show(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    render(conn, "show.html", question: question)
  end

  def edit(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    changeset = Questions.change_question(question)
    render(conn, "edit.html",
      question: question,
      changeset: changeset,
      categories: Categories.list_categories()
    )
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Questions.get_question!(id)

    case Questions.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: question_path(conn, :show, question))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          question: question,
          changeset: changeset,
          categories: Categories.list_categories()
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Questions.get_question!(id)
    {:ok, _question} = Questions.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: question_path(conn, :index))
  end
end
