class EventTimetable
  include ActiveModel::Model

  attr_reader :event, :weeks, :days

  EventDay = Struct.new(:date, :daily_plan, :tasks) do
    def daily_plan_recipes
      daily_plan.present? ? daily_plan.daily_plan_recipes : DailyPlanRecipe.none # This creates empty ActiveRecord::Relation object
    end

    def empty?
      daily_plan_recipes.none? && tasks.none?
    end
  end

  def initialize(event)
    @event = Event.includes(daily_plans: [
                              :day_tasks,
                              { daily_plan_recipes: {
                                  recipe: [ :rich_text_procedure, { recipe_ingredients: { ingredient: :measurement } } ]
                                }
                              } ])
                  .find(event.id)

    @days = date_range.map do |date|
      EventDay.new(date, @event.daily_plans.find { it.date == date }, [])
    end

    load_day_tasks

    @weeks = @days.to_a.in_groups_of(7)
  end


  def date_range
    start_date = @event.date_from
    end_date = @event.date_to

    @event.daily_plans.includes(daily_plan_recipes: [ recipe: :tasks ]).each do |plan|
      plan.daily_plan_recipes.each do |day_recipe|
        day_recipe.recipe.tasks.each do |task|
          date_of_task = day_recipe.daily_plan.date - task.days_before_cooking
          if date_of_task < start_date
            start_date = date_of_task
          end
        end
      end
    end

    (start_date.beginning_of_week..end_date.end_of_week)
  end

  private

  def load_day_tasks
    # Add daily tasks
    @days.each do |day|
      day.tasks = day.daily_plan.day_tasks.to_a if day.daily_plan.present?
    end

    # Add recipe tasks
    @event.daily_plans.includes(daily_plan_recipes: [ recipe: :tasks ]).each do |plan|
      plan.daily_plan_recipes.each do |day_recipe|
        day_recipe.recipe.tasks.each do |task|
          assign_task(day_recipe, task)
        end
      end
    end
  end

  def assign_task(daily_recipe, task)
    date_of_task = daily_recipe.daily_plan.date - task.days_before_cooking

    day = @days.find { _1.date == (date_of_task) }
    day.tasks << task
  end
end
