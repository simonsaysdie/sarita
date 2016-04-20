defmodule Sarita.Repo.Migrations.CreatePainting do
  use Ecto.Migration

  def change do
    create table(:paintings) do
      add :title, :string
      add :sold, :boolean, default: false
      add :price, :integer
      add :date, :string
      add :photo1, :string
      add :photo2, :string
      add :photo3, :string
      add :photo4, :string
      add :width, :integer
      add :height, :integer
      add :materials, :string

      timestamps
    end

  end
end
