# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = FactoryBot.create(:event)
    @recipe = FactoryBot.build(:hummus_with_carrot)
    @event.daily_plans.first.daily_plan_recipes.create(daily_plan: @event.daily_plans.first,
                                                       recipe: @recipe, order_index: 1,
                                                       portion_count: @event.portion_count)
    @event.daily_plans.first.day_tasks.create(name: 'task 1')
    @event.save
  end

  test 'creation' do
    assert @event.valid?
    assert_equal 3.days.from_now.to_date, @event.date_from
    assert_equal 3, @event.daily_plans.size
    assert_equal 1, @event.recipes.size
    assert_equal 1, @event.daily_plans.first.day_tasks.size
    assert_equal @recipe, @event.recipes.first
  end

  test 'duplication_into_new_event' do
    new_event = Event.new(name: 'event (copy)', date_from: @event.date_from + 3.days, date_to: @event.date_to + 3.days,
                          people_count: @event.people_count)
    new_event.save

    @event.duplicate_into(new_event)

    assert_equal 3, new_event.daily_plans.size
    assert_equal 1, new_event.recipes.size
    assert_equal 1, new_event.daily_plans.first.day_tasks.size
    assert_equal @recipe, new_event.recipes.first
  end
end
