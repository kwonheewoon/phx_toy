defmodule PhxToyWeb.Router do
  use PhxToyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhxToyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", PhxToyWeb do
  #   pipe_through :browser

  #   get "/", PageController, :home
  # end

  scope "/users", PhxToyWeb do
    pipe_through :api

    post "/", UserController, :create_user

    put "/:user_id", UserController, :update_user

    delete "/:user_id", UserController, :delete_user

    get "/", UserController, :find_user_all

    get "/:user_id", UserController, :find_user_one
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxToyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phx_toy, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhxToyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
