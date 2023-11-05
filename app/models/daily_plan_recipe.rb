# frozen_string_literal: true

class DailyPlanRecipe < ApplicationRecord
  self.table_name = 'daily_plans_have_recipes'

  MEAL_TYPES = ['snídaně', 'dopolední svačina', 'oběd', 'odpolední svačina', 'večeře', 'programové', 'jiné',
                'nákup'].freeze

  belongs_to :recipe
  belongs_to :daily_plan

  has_many :tasks, through: :recipe
  validates :portion_count, presence: true

  scope :shopping, -> { joins(:recipe).where('recipes.name = ? OR daily_plan_recipes.meal_type = ?', 'Nákup', 'nákup') }

  def shopping?
    recipe.shopping?
  end
end
