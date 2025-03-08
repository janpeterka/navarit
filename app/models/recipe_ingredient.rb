class RecipeIngredient < ApplicationRecord
  self.table_name = "recipes_have_ingredients"

  belongs_to :recipe
  belongs_to :ingredient

  delegate :name, to: :ingredient

  def recipe_amount
    return 0 if amount.nil?

    amount * recipe.portion_count
  end
end
