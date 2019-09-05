defmodule NetguruAssignmentWeb.Router do
  use NetguruAssignmentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NetguruAssignmentWeb do
    pipe_through :api
  end
end
