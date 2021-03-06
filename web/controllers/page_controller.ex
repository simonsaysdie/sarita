defmodule Sarita.PageController do
  use Sarita.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def bio(conn, _params) do
    render conn, "bio.html"
  end

  def oil_paintings(conn, _params) do
    render conn, "oil_paintings.html"
  end

  def finger_paintings(conn,_params) do
    render conn,"finger_paintings.html"
  end

  def acrylic(conn,_params) do
    render conn,"acrylic.html"
  end

  def sketches(conn,_params) do
    render conn,"sketches.html"
  end
  
end
