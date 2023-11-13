require "application_system_test_case"

class RecipeIngredientsTest < ApplicationSystemTestCase
  setup do
    @recipe_ingredient = recipe_ingredients(:one)
  end

  test "visiting the index" do
    visit recipe_ingredients_url
    assert_selector "h1", text: "Recipe ingredients"
  end

  test "should create recipe ingredient" do
    visit recipe_ingredients_url
    click_on "New recipe ingredient"

    click_on "Create Recipe ingredient"

    assert_text "Recipe ingredient was successfully created"
    click_on "Back"
  end

  test "should update Recipe ingredient" do
    visit recipe_ingredient_url(@recipe_ingredient)
    click_on "Edit this recipe ingredient", match: :first

    click_on "Update Recipe ingredient"

    assert_text "Recipe ingredient was successfully updated"
    click_on "Back"
  end

  test "should destroy Recipe ingredient" do
    visit recipe_ingredient_url(@recipe_ingredient)
    click_on "Destroy this recipe ingredient", match: :first

    assert_text "Recipe ingredient was successfully destroyed"
  end
end
