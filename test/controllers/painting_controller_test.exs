defmodule Sarita.PaintingControllerTest do
  use Sarita.ConnCase

  alias Sarita.Painting
  @valid_attrs %{date: "some content", height: 42, materials: "some content", photo1: "some content", photo2: "some content", photo3: "some content", photo4: "some content", price: 42, sold: true, title: "some content", width: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, painting_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing paintings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, painting_path(conn, :new)
    assert html_response(conn, 200) =~ "New painting"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, painting_path(conn, :create), painting: @valid_attrs
    assert redirected_to(conn) == painting_path(conn, :index)
    assert Repo.get_by(Painting, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, painting_path(conn, :create), painting: @invalid_attrs
    assert html_response(conn, 200) =~ "New painting"
  end

  test "shows chosen resource", %{conn: conn} do
    painting = Repo.insert! %Painting{}
    conn = get conn, painting_path(conn, :show, painting)
    assert html_response(conn, 200) =~ "Show painting"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, painting_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    painting = Repo.insert! %Painting{}
    conn = get conn, painting_path(conn, :edit, painting)
    assert html_response(conn, 200) =~ "Edit painting"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    painting = Repo.insert! %Painting{}
    conn = put conn, painting_path(conn, :update, painting), painting: @valid_attrs
    assert redirected_to(conn) == painting_path(conn, :show, painting)
    assert Repo.get_by(Painting, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    painting = Repo.insert! %Painting{}
    conn = put conn, painting_path(conn, :update, painting), painting: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit painting"
  end

  test "deletes chosen resource", %{conn: conn} do
    painting = Repo.insert! %Painting{}
    conn = delete conn, painting_path(conn, :delete, painting)
    assert redirected_to(conn) == painting_path(conn, :index)
    refute Repo.get(Painting, painting.id)
  end
end
