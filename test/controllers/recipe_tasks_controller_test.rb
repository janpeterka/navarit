require "test_helper"

class RecipeTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe_task = recipe_tasks(:one)
  end

  test "should get index" do
    get recipe_tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_task_url
    assert_response :success
  end

  test "should create recipe_task" do
    assert_difference("RecipeTask.count") do
      post recipe_tasks_url, params: { recipe_task: {} }
    end

    assert_redirected_to recipe_task_url(RecipeTask.last)
  end

  test "should show recipe_task" do
    get recipe_task_url(@recipe_task)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_task_url(@recipe_task)
    assert_response :success
  end

  test "should update recipe_task" do
    patch recipe_task_url(@recipe_task), params: { recipe_task: {} }
    assert_redirected_to recipe_task_url(@recipe_task)
  end

  test "should destroy recipe_task" do
    assert_difference("RecipeTask.count", -1) do
      delete recipe_task_url(@recipe_task)
    end

    assert_redirected_to recipe_tasks_url
  end
end
