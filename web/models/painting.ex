defmodule Sarita.Painting do
  use Sarita.Web, :model

  schema "paintings" do
    belongs_to :category, Sarita.Category
    field :title, :string
    field :sold, :boolean, default: false
    field :price, :integer
    field :date, :string
    field :photo1, :string
    field :photo2, :string
    field :photo3, :string
    field :photo4, :string
    field :width, :integer
    field :height, :integer
    field :materials, :string

    timestamps
  end

  @required_fields ~w(title sold price date photo1 photo2 photo3 photo4 width height materials)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
