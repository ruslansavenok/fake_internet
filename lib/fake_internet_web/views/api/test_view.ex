defmodule FakeInternetWeb.Api.TestView do
  use FakeInternetWeb, :view
  alias FakeInternetWeb.Api.TestView

  def render("index.json", %{tests: tests}) do
    %{data: render_many(tests, TestView, "test.json")}
  end

  def render("test.json", %{test: test}) do
    %{
      id: test.id,
      user_id: test.user_id,
      name: test.name,
      question_ids: test.question_ids
    }
  end
end
