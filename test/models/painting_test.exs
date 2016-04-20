defmodule Sarita.PaintingTest do
  use Sarita.ModelCase

  alias Sarita.Painting

  @valid_attrs %{date: "some content", height: 42, materials: "some content", photo1: "some content", photo2: "some content", photo3: "some content", photo4: "some content", price: 42, sold: true, title: "some content", width: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Painting.changeset(%Painting{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Painting.changeset(%Painting{}, @invalid_attrs)
    refute changeset.valid?
  end
end
