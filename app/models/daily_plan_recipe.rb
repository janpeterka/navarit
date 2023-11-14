# frozen_string_literal: true

class DailyPlanRecipe < ApplicationRecord
  self.table_name = 'daily_plans_have_recipes'

  MEAL_TYPES = ['snídaně', 'dopolední svačina', 'oběd', 'odpolední svačina', 'večeře', 'programové', 'jiné'].freeze

  belongs_to :recipe
  belongs_to :daily_plan
  has_many :tasks, through: :recipe

  validates :portion_count, presence: true
  validates :order_index, presence: true, numericality: { greater_than_or_equal_to: 1 }
  # uniqueness: { scope: :daily_plan_id }

  scope :shopping, -> { joins(:recipe).where('recipes.name = ? OR daily_plan_recipes.meal_type = ?', 'Nákup', 'nákup') }

  delegate :normalize_order_indices, to: :daily_plan
  # before_validation :set_order_index, on: :create

  def shopping?
    recipe.shopping?
  end

  def set_order_index
    self.order_index = daily_plan.daily_plan_recipes.maximum(:order_index) + 1
    normalize_order_indices
  end

  def move_to(new_position)
    old_position = order_index

    if new_position < old_position # moving up
      daily_plan.daily_plan_recipes.where(order_index: new_position..old_position).each do |dpr|
        dpr.update(order_index: dpr.order_index + 1)
      end
      update(order_index: new_position)
    end

    if old_position < new_position # moving down
      daily_plan.daily_plan_recipes.where(order_index: old_position + 1..new_position).each do |dpr|
        dpr.update(order_index: dpr.order_index - 1)
      end
      update(order_index: new_position)
    end

    daily_plan.normalize_order_indices
  end
end
