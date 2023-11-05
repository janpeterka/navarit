# frozen_string_literal: true

require 'test_helper'

class PublishedRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_recipe = published_recipes(:one)
  end

  test 'should get index' do
    get published_recipes_url
    assert_response :success
  end

  test 'should get new' do
    get new_published_recipe_url
    assert_response :success
  end

  test 'should create published_recipe' do
    assert_difference('PublishedRecipe.count') do
      post published_recipes_url, params: { published_recipe: {} }
    end

    assert_redirected_to published_recipe_url(PublishedRecipe.last)
  end

  test 'should show published_recipe' do
    get published_recipe_url(@published_recipe)
    assert_response :success
  end

  test 'should get edit' do
    get edit_published_recipe_url(@published_recipe)
    assert_response :success
  end

  test 'should update published_recipe' do
    patch published_recipe_url(@published_recipe), params: { published_recipe: {} }
    assert_redirected_to published_recipe_url(@published_recipe)
  end

  test 'should destroy published_recipe' do
    assert_difference('PublishedRecipe.count', -1) do
      delete published_recipe_url(@published_recipe)
    end

    assert_redirected_to published_recipes_url
  end
end
