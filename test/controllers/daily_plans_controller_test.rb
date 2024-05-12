# frozen_string_literal: true

require "test_helper"

class DailyPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_plan = daily_plans(:one)
  end

  test "should get index" do
    get daily_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_plan_url
    assert_response :success
  end

  test "should create daily_plan" do
    assert_difference("DailyPlan.count") do
      post daily_plans_url, params: { daily_plan: {} }
    end

    assert_redirected_to daily_plan_url(DailyPlan.last)
  end

  test "should show daily_plan" do
    get daily_plan_url(@daily_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_plan_url(@daily_plan)
    assert_response :success
  end

  test "should update daily_plan" do
    patch daily_plan_url(@daily_plan), params: { daily_plan: {} }
    assert_redirected_to daily_plan_url(@daily_plan)
  end

  test "should destroy daily_plan" do
    assert_difference("DailyPlan.count", -1) do
      delete daily_plan_url(@daily_plan)
    end

    assert_redirected_to daily_plans_url
  end
end
