# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  self.table_name = "recipes_have_ingredients"

  belongs_to :recipe
  belongs_to :ingredient

  validates :amount, presence: true

  scope :measured, -> { where.not(amount: nil) }

  delegate :name, to: :ingredient

  def recipe_amount
    return 0 if amount.nil?

    amount * recipe.portion_count
  end
end
