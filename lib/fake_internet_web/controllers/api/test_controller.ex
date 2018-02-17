defmodule FakeInternetWeb.Api.TestController do
  use FakeInternetWeb, :controller
  alias FakeInternet.Tests
  alias FakeInternet.Tests.Test

  action_fallback FakeInternetWeb.FallbackController

  def index(conn, _params) do
    [authorization_header] = get_req_header(conn, "authorization")
    authorization_token = String.replace(authorization_header, "Bearer ", "")

    case Phoenix.Token.verify(conn, "user_token", authorization_token) do
      {:ok, user_id} ->
        render(conn, "index.json", tests: Tests.list_user_tests(user_id))
      {:error, _} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid user"})
    end
  end

  def create(conn, test_params) do
    [authorization_header] = get_req_header(conn, "authorization")
    authorization_token = String.replace(authorization_header, "Bearer ", "")

    # TODO: Multiline with??
    with {:ok, user_id} <- Phoenix.Token.verify(conn, "user_token", authorization_token),
         {:ok, %Test{} = test} <- Map.merge(test_params, %{"user_id" => user_id}) |> Tests.create_test do
      render(conn, "test.json", test: test)
    end
  end
end
