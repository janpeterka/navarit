# frozen_string_literal: true

class DailyPlan < ApplicationRecord
  belongs_to :event, touch: true
  belongs_to :author, class_name: "User", foreign_key: "created_by", default: -> { event.author } # TODO: remove

  has_many :day_tasks, class_name: "DailyPlanTask", dependent: :destroy
  has_many :daily_plan_recipes, -> { order(position: :asc) }, dependent: :destroy
  has_many :recipes, through: :daily_plan_recipes

  validates :date, presence: true, uniqueness: { scope: :event_id }

  delegate :portion_count, to: :event

  scope :filled, -> { joins(:recipes).distinct.any? }
  scope :on, ->(date) { where("daily_plans.date = ?", date).first }
  scope :on_or_after, ->(date) { where("daily_plans.date >= ?", date) }
  scope :before, ->(date) { where("daily_plans.date < ?", date) }
  scope :after, ->(date) { where("daily_plans.date > ?", date) }

  def tasks
    @tasks = []
    @tasks << day_tasks.to_a
    @tasks << tasks_from_recipes

    @tasks.flatten!
  end

  def duplicate
    duplicate_daily_plan = dup
    duplicate_daily_plan.day_tasks = day_tasks.map(&:dup)
    duplicate_daily_plan.author = author

    daily_plan_recipes.each do |dpr|
      duplicate_daily_plan_recipe = dpr.duplicate
      duplicate_daily_plan_recipe.daily_plan = duplicate_daily_plan
      duplicate_daily_plan.daily_plan_recipes << duplicate_daily_plan_recipe
    end

    duplicate_daily_plan
  end

  private

  def tasks_from_recipes
    tasks = []

    event.daily_plans.on_or_after(date).each_with_index do |plan, index|
      plan.recipes.each do |recipe|
        tasks << recipe.tasks.where(days_before_cooking: index)
      end
    end

    tasks
  end
end
