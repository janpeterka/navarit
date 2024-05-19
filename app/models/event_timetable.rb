# frozen_string_literal: true

class EventTimetable
  include ActiveModel::Model

  attr_reader :event, :weeks, :days

  def initialize(event)
    @event = Event.includes(daily_plans: [ :day_tasks, daily_plan_recipes: :recipe ]).find(event.id)

    event_day = Struct.new(:date, :daily_plan, :tasks)

    date_range = (@event.date_from.beginning_of_week..@event.date_to.end_of_week)

    @days = date_range.map do |date|
      event_day.new(date, @event.daily_plans.find { _1.date == date })
    end

    load_day_tasks

    @weeks = @days.to_a.in_groups_of(7)
  end

  private

  def load_day_tasks
    # Add daily tasks
    @days.each do |day|
      if day.daily_plan.present?
        day.tasks = day.daily_plan.day_tasks.to_a
      else
        day.tasks = []
      end
    end

    # Add recipe tasks
    @event.daily_plans.includes(daily_plan_recipes: [ recipe: :tasks ]).each do |plan|
      plan.daily_plan_recipes.each do |day_recipe|
        day_recipe.recipe.tasks.each do |task|
          # day.tasks << recipe.tasks.where(days_before_cooking: plan.date - day.date)
          assign_task(day_recipe, task)
        end
      end
    end
  end

  def assign_task(daily_recipe, task)
    day = @days.find { _1.date == (daily_recipe.daily_plan.date - task.days_before_cooking) }
    day.tasks << task
  end
end
