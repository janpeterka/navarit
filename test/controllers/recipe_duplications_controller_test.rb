require "test_helper"

class RecipeDuplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe_duplication = recipe_duplications(:one)
  end

  test "should get index" do
    get recipe_duplications_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_duplication_url
    assert_response :success
  end

  test "should create recipe_duplication" do
    assert_difference("RecipeDuplication.count") do
      post recipe_duplications_url, params: { recipe_duplication: {} }
    end

    assert_redirected_to recipe_duplication_url(RecipeDuplication.last)
  end

  test "should show recipe_duplication" do
    get recipe_duplication_url(@recipe_duplication)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_duplication_url(@recipe_duplication)
    assert_response :success
  end

  test "should update recipe_duplication" do
    patch recipe_duplication_url(@recipe_duplication), params: { recipe_duplication: {} }
    assert_redirected_to recipe_duplication_url(@recipe_duplication)
  end

  test "should destroy recipe_duplication" do
    assert_difference("RecipeDuplication.count", -1) do
      delete recipe_duplication_url(@recipe_duplication)
    end

    assert_redirected_to recipe_duplications_url
  end
end
