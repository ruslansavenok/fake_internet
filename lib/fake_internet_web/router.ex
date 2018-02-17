defmodule FakeInternetWeb.Router do
  use FakeInternetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FakeInternetWeb do
    pipe_through :browser

    get "/", PageController, :index

    scope "/admin" do
      resources "/categories", CategoryController
      resources "/questions", QuestionController
      resources "/users", Admin.UserController
    end
  end

  scope "/api", FakeInternetWeb.Api do
    pipe_through :api
    post "/sign_up", UserController, :sign_up
    post "/sign_in", UserController, :sign_in
  end
end
