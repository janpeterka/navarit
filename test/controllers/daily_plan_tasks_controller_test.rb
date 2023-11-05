# frozen_string_literal: true

require 'test_helper'

class DailyPlanTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_plan_task = daily_plan_tasks(:one)
  end

  test 'should get index' do
    get daily_plan_tasks_url
    assert_response :success
  end

  test 'should get new' do
    get new_daily_plan_task_url
    assert_response :success
  end

  test 'should create daily_plan_task' do
    assert_difference('DailyPlanTask.count') do
      post daily_plan_tasks_url, params: { daily_plan_task: {} }
    end

    assert_redirected_to daily_plan_task_url(DailyPlanTask.last)
  end

  test 'should show daily_plan_task' do
    get daily_plan_task_url(@daily_plan_task)
    assert_response :success
  end

  test 'should get edit' do
    get edit_daily_plan_task_url(@daily_plan_task)
    assert_response :success
  end

  test 'should update daily_plan_task' do
    patch daily_plan_task_url(@daily_plan_task), params: { daily_plan_task: {} }
    assert_redirected_to daily_plan_task_url(@daily_plan_task)
  end

  test 'should destroy daily_plan_task' do
    assert_difference('DailyPlanTask.count', -1) do
      delete daily_plan_task_url(@daily_plan_task)
    end

    assert_redirected_to daily_plan_tasks_url
  end
end
