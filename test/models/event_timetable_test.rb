require "test_helper"

class EventTimetableTest < ActiveSupport::TestCase
  def setup
    date_from = Date.new(2024, 1, 2) # Tuesday 2.1.2024
    date_to = Date.new(2024, 1, 12) # Friday 12.1.2024
    @event = FactoryBot.create(:event, date_from:, date_to:, author: @current_user)
  end

  test "is in whole weeks" do
    assert(@event.timetable.days.size == 14)
    assert(@event.timetable.days.first.date.monday?)
    assert(@event.timetable.days.last.date.sunday?)
  end

  test "assigns recipe tasks correctly" do
    recipe = FactoryBot.create(:hummus_with_carrot, author: @current_user)
    recipe_task =  recipe.tasks.create!(name: "Buy carrot one day before", days_before_cooking: 1)

    assert recipe.tasks.size == 1

    @event.daily_plans.find_by(date: "2024-01-03").daily_plan_recipes.create!(recipe:, portion_count: 12)

    assert @event.recipes.include?(recipe)

    assert @event.timetable.days.find { _1.date == Date.new(2024, 1, 2) }.tasks == [ recipe_task ]
  end
end
