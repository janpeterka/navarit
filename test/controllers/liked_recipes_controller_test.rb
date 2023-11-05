# frozen_string_literal: true

require 'test_helper'

class LikedRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liked_recipe = liked_recipes(:one)
  end

  test 'should get index' do
    get liked_recipes_url
    assert_response :success
  end

  test 'should get new' do
    get new_liked_recipe_url
    assert_response :success
  end

  test 'should create liked_recipe' do
    assert_difference('LikedRecipe.count') do
      post liked_recipes_url, params: { liked_recipe: {} }
    end

    assert_redirected_to liked_recipe_url(LikedRecipe.last)
  end

  test 'should show liked_recipe' do
    get liked_recipe_url(@liked_recipe)
    assert_response :success
  end

  test 'should get edit' do
    get edit_liked_recipe_url(@liked_recipe)
    assert_response :success
  end

  test 'should update liked_recipe' do
    patch liked_recipe_url(@liked_recipe), params: { liked_recipe: {} }
    assert_redirected_to liked_recipe_url(@liked_recipe)
  end

  test 'should destroy liked_recipe' do
    assert_difference('LikedRecipe.count', -1) do
      delete liked_recipe_url(@liked_recipe)
    end

    assert_redirected_to liked_recipes_url
  end
end
