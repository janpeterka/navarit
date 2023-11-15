# frozen_string_literal: true

class DailyPlan < ApplicationRecord
  belongs_to :event
  belongs_to :author, class_name: 'User', foreign_key: 'created_by'

  has_many :day_tasks, class_name: 'DailyPlanTask', dependent: :destroy
  has_many :daily_plan_recipes, -> { order(order_index: :asc) }, dependent: :destroy
  has_many :recipes, through: :daily_plan_recipes

  validates :date, presence: true

  delegate :portion_count, to: :event

  scope :filled, -> { joins(:recipes).distinct.any? }
  scope :on_or_after, ->(date) { where('daily_plans.date >= ?', date) }
  # scope :after, ->(date) { where('daily_plans.date > ?', date) }

  def tasks
    @tasks = []
    @tasks << day_tasks.to_a
    event.daily_plans.on_or_after(date).each_with_index do |plan, index|
      plan.recipes.each do |recipe|
        @tasks << recipe.tasks.where(days_before_cooking: index)
      end
    end
    @tasks.flatten!
  end

  def normalize_order_indices
    daily_plan_recipes.each_with_index do |dpr, index|
      dpr.update!(order_index: index + 1)
    end
  end
end
