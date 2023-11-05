require "application_system_test_case"

class DailyPlanTasksTest < ApplicationSystemTestCase
  setup do
    @daily_plan_task = daily_plan_tasks(:one)
  end

  test "visiting the index" do
    visit daily_plan_tasks_url
    assert_selector "h1", text: "Daily plan tasks"
  end

  test "should create daily plan task" do
    visit daily_plan_tasks_url
    click_on "New daily plan task"

    click_on "Create Daily plan task"

    assert_text "Daily plan task was successfully created"
    click_on "Back"
  end

  test "should update Daily plan task" do
    visit daily_plan_task_url(@daily_plan_task)
    click_on "Edit this daily plan task", match: :first

    click_on "Update Daily plan task"

    assert_text "Daily plan task was successfully updated"
    click_on "Back"
  end

  test "should destroy Daily plan task" do
    visit daily_plan_task_url(@daily_plan_task)
    click_on "Destroy this daily plan task", match: :first

    assert_text "Daily plan task was successfully destroyed"
  end
end
