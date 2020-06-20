# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fish,
  ecto_repos: [Fish.Repo]

# Configures the endpoint
config :fish, FishWeb.Endpoint,
  url: [host: "localhost"],
  load_from_system_env: true,
  secret_key_base: "nOPS8kJTmAZtcgOpGVo7fMrAbFCCUVySKShVewMdaudersQgSLszNnTqb36fm71I",
  render_errors: [view: FishWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Fish.PubSub,
  live_view: [signing_salt: "i1ucCSg6"]

config :fish, :pow,
  user: Fish.Users.User,
  repo: Fish.Repo,
  extensions: [PowResetPassword],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  web_module: FishWeb,
  mailer_backend: FishWeb.Pow.Mailer

config :fish, :pow_assent,
  providers: [
    github: [
      client_id: "REPLACE_WITH_CLIENT_ID",
      client_secret: "REPLACE_WITH_CLIENT_SECRET",
      strategy: Assent.Strategy.Github
    ]
    # example: [
    #   client_id: "REPLACE_WITH_CLIENT_ID",
    #   site: "https://server.example.com",
    #   authorization_params: [scope: "user:read user:write"],
    #   nonce: true,
    #   strategy: Assent.Strategy.OIDC
    # ]
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
