class RecipeLabel < ActiveRecord
  belongs_to :recipe
  belongs_to :label
end
