# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  self.table_name = 'recipes_have_ingredients'

  belongs_to :recipe
  belongs_to :ingredient

  validates_presence_of :amount

  scope :measured, -> { where.not(amount: nil) }

  def recipe_amount
    amount * recipe.portion_count
  end
end
