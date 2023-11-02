class DailyPlan < ApplicationRecord
  belongs_to :event
  belongs_to :author, class_name: 'User'

  has_many :daily_plan_tasks
  has_many :day_tasks, through: :daily_plan_tasks
  has_many :daily_plan_recipes, -> { order(order_index: :desc) }
  has_many :recipes, through: :daily_plan_recipes

  validates :date, presence: true

  scope :filled, -> { joins(:recipes).distinct.any? }

  def tasks
    tasks << day_tasks
    # TODO: tasks from recipes, with correct datelambda
  end
end
