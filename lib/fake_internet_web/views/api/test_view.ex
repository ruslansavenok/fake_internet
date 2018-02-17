defmodule FakeInternetWeb.Api.TestView do
  use FakeInternetWeb, :view
  alias FakeInternetWeb.Api.TestView

  def render("index.json", %{tests: tests}) do
    %{data: render_many(tests, TestView, "test.json")}
  end

  def render("test.json", %{test: test}) do
    %{
      id: test.id,
      name: test.name
    }
  end
end
