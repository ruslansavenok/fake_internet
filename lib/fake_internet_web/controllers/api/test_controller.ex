defmodule FakeInternetWeb.Api.TestController do
  use FakeInternetWeb, :controller
  alias FakeInternet.Tests

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
end
