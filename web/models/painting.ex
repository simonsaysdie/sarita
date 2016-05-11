defmodule Sarita.Painting do
  use Sarita.Web, :model
  use Arc.Ecto.Model

  schema "paintings" do
    belongs_to :category, Sarita.Category
    field :title, :string
    field :sold, :boolean, default: false
    field :price, :integer
    field :date, :string
    field :photo1, Sarita.PaintingPhoto.Type
    field :photo2, Sarita.PaintingPhoto.Type
    field :photo3, Sarita.PaintingPhoto.Type
    field :photo4, Sarita.PaintingPhoto.Type
    field :width, :integer
    field :height, :integer
    field :materials, :string

    timestamps
  end

  @required_fields ~w(title sold price date width height materials)
  @optional_fields ~w()

  @required_file_fields ~w(photo1)
  @optional_file_fields ~w(photo2 photo3 photo4)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end
end
