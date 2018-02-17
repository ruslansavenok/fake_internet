defmodule FakeInternetWeb.Api.QuestionView do
  use FakeInternetWeb, :view
  alias FakeInternetWeb.Api.QuestionView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{
      id: question.id,
      question: question.question,
      image_path: FakeInternet.QuestionImage.url({ question.image, question }),
      category_id: question.category_id
    }
  end
end
