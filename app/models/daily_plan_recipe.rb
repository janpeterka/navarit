class DailyPlanRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :daily_plan

  has_many :tasks, through: :recipe
  validates :portion_count, presence: true

  scope :shopping, -> { joins(:recipe).where("recipes.name = ? OR daily_plan_recipes.meal_type = ?", "Nákup", "nákup") }
end
