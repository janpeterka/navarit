class RecipeIngredient < ApplicationRecord
  table_name "recipes_have_ingredients"

  belongs_to :recipe
  belongs_to :ingredient

  validates :amount, presence: true

  scope :measured, -> { where.not(amount: nil) }
end
