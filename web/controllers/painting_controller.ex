defmodule Sarita.PaintingController do
  use Sarita.Web, :controller

  alias Sarita.Painting

  plug :scrub_params, "painting" when action in [:create, :update]

  def index(conn, _params) do
    paintings = Repo.all(Painting)
    render(conn, "index.html", paintings: paintings)
  end

  def new(conn, _params) do
    changeset = Painting.changeset(%Painting{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"painting" => painting_params}) do
    changeset = Painting.changeset(%Painting{}, painting_params)

    case Repo.insert(changeset) do
      {:ok, _painting} ->
        conn
        |> put_flash(:info, "Painting created successfully.")
        |> redirect(to: painting_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    painting = Repo.get!(Painting, id)
    render(conn, "show.html", painting: painting)
  end

  def edit(conn, %{"id" => id}) do
    painting = Repo.get!(Painting, id)
    changeset = Painting.changeset(painting)
    render(conn, "edit.html", painting: painting, changeset: changeset)
  end

  def update(conn, %{"id" => id, "painting" => painting_params}) do
    painting = Repo.get!(Painting, id)
    changeset = Painting.changeset(painting, painting_params)

    case Repo.update(changeset) do
      {:ok, painting} ->
        conn
        |> put_flash(:info, "Painting updated successfully.")
        |> redirect(to: painting_path(conn, :show, painting))
      {:error, changeset} ->
        render(conn, "edit.html", painting: painting, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    painting = Repo.get!(Painting, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(painting)

    conn
    |> put_flash(:info, "Painting deleted successfully.")
    |> redirect(to: painting_path(conn, :index))
  end
end
