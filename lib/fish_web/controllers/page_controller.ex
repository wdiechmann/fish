defmodule FishWeb.PageController do
  use FishWeb, :controller

  # Landing page
  def index(conn, _params) do
    render(conn, "index.html")
  end

  # SOLUTION

  # SUPPORT
  def pricing(conn, _params) do
    render(conn, "pricing.html")
  end

  def documentation(conn, _params) do
    render(conn, "documentation.html")
  end

  def guides(conn, _params) do
    render(conn, "guides.html")
  end

  def api_status(conn, _params) do
    render(conn, "api_status.html")
  end

  # COMPANY pages
  def about(conn, _params) do
    render(conn, "about.html")
  end

  def jobs(conn, _params) do
    render(conn, "jobs.html")
  end

  def press(conn, _params) do
    render(conn, "press.html")
  end

  def partners(conn, _params) do
    render(conn, "partners.html")
  end

  # LEGAL pages
  def claims(conn, _params) do
    render(conn, "claims.html")
  end

  def gdpr(conn, _params) do
    render(conn, "gdpr.html")
  end

  def terms(conn, _params) do
    render(conn, "terms.html")
  end
end
