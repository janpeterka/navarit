# frozen_string_literal: true

require "test_helper"

class EventShoppingListTest < ActiveSupport::TestCase
  def setup
    @event = FactoryBot.create(:event_with_shoppings)
    @recipe = FactoryBot.build(:hummus_with_carrot)
    @event.daily_plans.first.daily_plan_recipes.create(daily_plan: @event.daily_plans.first,
                                                       recipe: @recipe, position: 1,
                                                       portion_count: @event.portion_count)
    @event.save
    @event_shopping_list = EventShoppingList.new(@event)
  end

  test "event without specified shoppings having 2 shoppings" do
    assert_equal 2, @event_shopping_list.shoppings.count
  end

  test "event with 1 specified shopping having 3 shoppings" do
    shopping = FactoryBot.create(:shopping)
    @event.daily_plans.third.daily_plan_recipes.create!(daily_plan: @event.daily_plans.first,
                                                        recipe: shopping, portion_count: 1, position: 1)
    assert_equal 3, EventShoppingList.new(@event).shoppings.count
  end

  # test 'initial shopping contains lasting ingredients' do
  # end

  # test 'shopping contains ingredients it should' do
  # end
end
