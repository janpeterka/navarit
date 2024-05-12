class DailyPlanRecipe < ApplicationRecord
  self.table_name = "daily_plans_have_recipes"

  MEAL_TYPES = [ "snídaně", "dopolední svačina", "oběd", "odpolední svačina", "večeře", "programové", "jiné" ].freeze

  belongs_to :recipe
  belongs_to :daily_plan
  acts_as_list scope: :daily_plan
  has_many :tasks, through: :recipe

  validates :portion_count, presence: true
  # validates :position, presence: true, numericality: { greater_than_or_equal_to: 1 } # this is not validated, as it is set by acts_as_list after validations

  scope :shopping, -> { joins(:recipe).where("recipes.name = ? OR daily_plan_recipes.meal_type = ?", "Nákup", "nákup") }

  delegate :date, to: :daily_plan
  delegate :shopping?, to: :recipe

  def duplicate
    duplicate_daily_plan_recipe = dup
    duplicate_daily_plan_recipe.recipe = recipe

    duplicate_daily_plan_recipe
  end

  def ingredients_with_amounts
    ingredients_with_amounts = {}

    recipe.recipe_ingredients.each do |recipe_ingredient|
      ingredients_with_amounts[recipe_ingredient.ingredient] = recipe_ingredient.amount * portion_count
    end

    ingredients_with_amounts
  end
end
