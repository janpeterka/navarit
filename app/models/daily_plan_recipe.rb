# frozen_string_literal: true

class DailyPlanRecipe < ApplicationRecord
  self.table_name = 'daily_plans_have_recipes'

  MEAL_TYPES = ['snídaně', 'dopolední svačina', 'oběd', 'odpolední svačina', 'večeře', 'programové', 'jiné'].freeze

  belongs_to :recipe
  belongs_to :daily_plan
  has_many :tasks, through: :recipe

  validates :portion_count, presence: true
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 1 }
  # uniqueness: { scope: :daily_plan_id }

  scope :shopping, -> { joins(:recipe).where('recipes.name = ? OR daily_plan_recipes.meal_type = ?', 'Nákup', 'nákup') }

  delegate :normalize_order_indices, to: :daily_plan
  delegate :shopping?, to: :recipe
  # before_validation :set_order_index, on: :create

  def set_position
    self.position = daily_plan.daily_plan_recipes.maximum(:position) || 0 + 1
    normalize_order_indices
  end

  def sort_to(new_position)
    old_position = position

    if new_position < old_position # moving up
      daily_plan.daily_plan_recipes.where(position: new_position..old_position).each do |dpr|
        dpr.update(position: dpr.position + 1)
      end
      update(position: new_position)
    end

    if old_position < new_position # moving down
      daily_plan.daily_plan_recipes.where(position: old_position..new_position).each do |dpr|
        dpr.update(position: dpr.position - 1)
      end
      update(position: new_position)
    end

    daily_plan.normalize_order_indices
  end

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
