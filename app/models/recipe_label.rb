class RecipeLabel < ApplicationRecord
  belongs_to :recipe
  belongs_to :label
end
