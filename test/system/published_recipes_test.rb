require "application_system_test_case"

class PublishedRecipesTest < ApplicationSystemTestCase
  setup do
    @published_recipe = published_recipes(:one)
  end

  test "visiting the index" do
    visit published_recipes_url
    assert_selector "h1", text: "Published recipes"
  end

  test "should create published recipe" do
    visit published_recipes_url
    click_on "New published recipe"

    click_on "Create Published recipe"

    assert_text "Published recipe was successfully created"
    click_on "Back"
  end

  test "should update Published recipe" do
    visit published_recipe_url(@published_recipe)
    click_on "Edit this published recipe", match: :first

    click_on "Update Published recipe"

    assert_text "Published recipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Published recipe" do
    visit published_recipe_url(@published_recipe)
    click_on "Destroy this published recipe", match: :first

    assert_text "Published recipe was successfully destroyed"
  end
end
