defmodule Sarita.PaintingController do
  use Sarita.Web, :controller

  alias Sarita.Painting
  alias Sarita.Repo
  alias Sarita.Category
  alias Sarita.PhotoWriter

  plug :scrub_params, "painting" when action in [:create, :update]

  def index(conn, _params) do
    paintings = Repo.all(Painting)
    render(conn, "index.html", paintings: paintings)
  end

  def new(conn, _params) do
    categories = Repo.all(Category)
    changeset = Painting.changeset(%Painting{})
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"painting" => painting_params}) do
    painting_params = insert_photos(painting_params)
    changeset = Painting.changeset(%Painting{}, painting_params)
    categories = Repo.all(Category)

    case Repo.insert(changeset) do
      {:ok, _painting} ->
        conn
        |> put_flash(:info, "Painting created successfully.")
        |> redirect(to: painting_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, categories: categories)
    end
  end

  defp insert_photos(painting_params) do
    photo1 = PhotoWriter.parse_img(painting_params, "photo1")
    photo2 = PhotoWriter.parse_img(painting_params, "photo2")
    photo3 = PhotoWriter.parse_img(painting_params, "photo3")
    photo4 = PhotoWriter.parse_img(painting_params, "photo4")
    photos = [photo1, photo2, photo3, photo4]
    Map.put(painting_params, "photo1", Enum.at(photos, 0))
    |> Map.put("photo2", Enum.at(photos, 1))
    |> Map.put("photo3", Enum.at(photos, 2))
    |> Map.put("photo4", Enum.at(photos, 3))
  end

  def show(conn, %{"id" => id}) do
    painting = Repo.get!(Painting, id)
    render(conn, "show.html", painting: painting)
  end

  def edit(conn, %{"id" => id}) do
    painting = Repo.get!(Painting, id)
    changeset = Painting.changeset(painting)
    categories = Repo.all(Category)
    render(conn, "edit.html", painting: painting, 
                              changeset: changeset, 
                              categories: categories)
  end

  def update(conn, %{"id" => id, "painting" => painting_params}) do
    painting = Repo.get!(Painting, id)
    changeset = Painting.changeset(painting, painting_params)
    categories = Repo.all(Category)
 
    case Repo.update(changeset) do
      {:ok, painting} ->
        conn
        |> put_flash(:info, "Painting updated successfully.")
        |> redirect(to: painting_path(conn, :show, painting))
      {:error, changeset} ->
        render(conn, "edit.html", painting: painting, 
                                  changeset: changeset,
                                  categories: categories)
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
