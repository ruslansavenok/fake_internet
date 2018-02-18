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
      question_ids: test.question_ids,
      submissions: Enum.map(test.submissions, fn submission ->
        %{
          id: submission.id,
          user_id: submission.user_id,
          answers: Enum.map(submission.answers, fn answer ->
            %{
              question_id: answer.question_id,
              answer_id: answer.answer_id
            }
          end)
        }
      end)
    }
  end
end
