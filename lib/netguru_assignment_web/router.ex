defmodule NetguruAssignmentWeb.Router do
  use NetguruAssignmentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug NetguruAssignment.Auth.Pipeline
  end

  scope "/api/protected", NetguruAssignmentWeb do
    pipe_through [:api, :auth]

    resources "/authors", AuthorController, only: [:show, :update, :delete]
    resources "/articles", ArticleController, except: [:new, :edit]
  end

  scope "/api", NetguruAssignmentWeb do
    pipe_through :api

    post "/author", AuthorController, :create
  end
end
