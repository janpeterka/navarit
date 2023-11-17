# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    Current.user = FactoryBot.build(:user)

    @event = FactoryBot.create(:event)
    @recipe = FactoryBot.build(:hummus_with_carrot)
    @event.daily_plans.first.daily_plan_recipes.create(daily_plan: @event.daily_plans.first,
                                                       recipe: @recipe, order_index: 1,
                                                       portion_count: @event.portion_count)
    @event.save

    assert_equal @event.date_from, 3.days.from_now.to_date
  end

  test 'creation' do
    assert @event.valid?
    assert_equal @event.daily_plans.size, 3
    assert_equal @event.recipes.size, 1
    assert_equal @event.recipes.first, @recipe
  end

  test 'duplication' do
    new_event = @event.duplicate
    new_event.save

    assert_equal "#{@event.name} (kopie)", new_event.name
    assert_equal @event.date_from, new_event.date_from
    assert_equal 3, new_event.daily_plans.size
    assert_equal 1, new_event.recipes.size
    assert_equal @recipe, new_event.recipes.first
  end

  test 'duplication_into_new_event' do
    new_event = Event.new(name: 'event (copy)', date_from: @event.date_from + 3.days, date_to: @event.date_to + 3.days,
                          people_count: @event.people_count)
    new_event.save

    @event.duplicate_into(new_event)

    assert_equal 3, new_event.daily_plans.size
    assert_equal 1, new_event.recipes.size
    assert_equal @recipe, new_event.recipes.first
  end
end
