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
    assert_equal @event.date_from, 3.days.from_now.to_date
  end

  test 'creation' do
    assert @event.valid?
    assert @event.daily_plans.size == 3
    assert @event.recipes.size == 1
    assert @event.recipes.first == @recipe
  end

  test 'duplication' do
    new_event = @event.duplicate

    assert_equal new_event.name, "#{@event.name} (kopie)"
    assert_equal new_event.date_from, @event.date_from
  end
end
