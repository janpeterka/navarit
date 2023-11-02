require "test_helper"

class DailyPlanRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_plan_recipe = daily_plan_recipes(:one)
  end

  test "should get index" do
    get daily_plan_recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_plan_recipe_url
    assert_response :success
  end

  test "should create daily_plan_recipe" do
    assert_difference("DailyPlanRecipe.count") do
      post daily_plan_recipes_url, params: { daily_plan_recipe: {  } }
    end

    assert_redirected_to daily_plan_recipe_url(DailyPlanRecipe.last)
  end

  test "should show daily_plan_recipe" do
    get daily_plan_recipe_url(@daily_plan_recipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_plan_recipe_url(@daily_plan_recipe)
    assert_response :success
  end

  test "should update daily_plan_recipe" do
    patch daily_plan_recipe_url(@daily_plan_recipe), params: { daily_plan_recipe: {  } }
    assert_redirected_to daily_plan_recipe_url(@daily_plan_recipe)
  end

  test "should destroy daily_plan_recipe" do
    assert_difference("DailyPlanRecipe.count", -1) do
      delete daily_plan_recipe_url(@daily_plan_recipe)
    end

    assert_redirected_to daily_plan_recipes_url
  end
end
