defmodule Sarita.Router do
  use Sarita.Web, :router

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

  scope "/", Sarita do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/bio", PageController, :bio
    get "/oil_paintings", PageController, :oil_paintings
    get "/finger_paintings", PageController, :finger_paintings
    get "/acrylic", PageController, :acrylic
    get "/sketches", PageController, :sketches
    


    resources "/paintings", PaintingController
    resources "/categories", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Sarita do
  #   pipe_through :api
  # end
end
