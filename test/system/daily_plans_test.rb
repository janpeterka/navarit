# frozen_string_literal: true

require 'application_system_test_case'

class DailyPlansTest < ApplicationSystemTestCase
  setup do
    @daily_plan = daily_plans(:one)
  end

  test 'visiting the index' do
    visit daily_plans_url
    assert_selector 'h1', text: 'Daily plans'
  end

  test 'should create daily plan' do
    visit daily_plans_url
    click_on 'New daily plan'

    click_on 'Create Daily plan'

    assert_text 'Daily plan was successfully created'
    click_on 'Back'
  end

  test 'should update Daily plan' do
    visit daily_plan_url(@daily_plan)
    click_on 'Edit this daily plan', match: :first

    click_on 'Update Daily plan'

    assert_text 'Daily plan was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Daily plan' do
    visit daily_plan_url(@daily_plan)
    click_on 'Destroy this daily plan', match: :first

    assert_text 'Daily plan was successfully destroyed'
  end
end
