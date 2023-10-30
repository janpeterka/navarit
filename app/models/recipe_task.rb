class RecipeTask < ActiveRecord
  belongs_to :recipe

  validates :name, presence: true
end
