defmodule Sarita.PaintingView do
  use Sarita.Web, :view
  require IEx
  alias Sarita.PaintingPhoto
   def parse_categories(categories) do
    categories = Enum.map(categories, fn(category) -> 
              {String.to_atom(category.name), category.id}
            end)
    List.flatten [categories]
  end

  def img_url(img) do
    PaintingPhoto.url(img)
    |> String.replace("priv/static", "")
  end
end
