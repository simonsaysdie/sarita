defmodule Sarita.PaintingView do
  use Sarita.Web, :view
   def parse_categories(categories) do
    categories = Enum.map(categories, fn(category) -> 
              {String.to_atom(category.name), category.id}
            end)
    List.flatten [categories]
  end
end
