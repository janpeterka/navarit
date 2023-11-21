# frozen_string_literal: true

class EventTimetable
  include ActiveModel::Model

  attr_reader :event, :weeks, :days

  def initialize(event)
    @event = event

    event_day = Struct.new(:date, :daily_plan, :tasks)

    @days = (@event.date_from.beginning_of_week..@event.date_to.end_of_week)

    @days = @days.map do |date|
      event_day.new(date, @event.daily_plans.find_by(date:))
    end

    @days.each do |day|
      if day.daily_plan.present?
        day.tasks = day.daily_plan&.tasks
      else
        day.tasks = []
        @event.daily_plans.on_or_after(day.date).each do |plan|
          plan.recipes.each do |recipe|
            day.tasks << recipe.tasks.where(days_before_cooking: plan.date - day.date)
          end
        end
      end
      day.tasks.flatten!
    end

    # p @days

    @weeks = @days.to_a.in_groups_of(7)

    # p @weeks
  end
end
