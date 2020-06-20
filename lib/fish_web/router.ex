defmodule FishWeb.Router do
  use FishWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {FishWeb.LayoutView, "root.html"}
  end

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
    pow_assent_routes()
  end

  scope "/", FishWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/pricing", PageController, :pricing
    get "/documentation", PageController, :documentation
    get "/guides", PageController, :guides
    get "/api_status", PageController, :api_status
    get "/about", PageController, :about
    get "/jobs", PageController, :jobs
    get "/press", PageController, :press
    get "/partners", PageController, :partners

    get "/claims", PageController, :claims
    get "/gdpr", PageController, :gdpr
    get "/terms", PageController, :terms
  end

  scope "/", FishWeb do
    pipe_through [:browser]

    resources "/blogs", BlogController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FishWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FishWeb.Telemetry
    end
  end
end
