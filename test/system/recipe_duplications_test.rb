require "application_system_test_case"

class RecipeDuplicationsTest < ApplicationSystemTestCase
  setup do
    @recipe_duplication = recipe_duplications(:one)
  end

  test "visiting the index" do
    visit recipe_duplications_url
    assert_selector "h1", text: "Recipe duplications"
  end

  test "should create recipe duplication" do
    visit recipe_duplications_url
    click_on "New recipe duplication"

    click_on "Create Recipe duplication"

    assert_text "Recipe duplication was successfully created"
    click_on "Back"
  end

  test "should update Recipe duplication" do
    visit recipe_duplication_url(@recipe_duplication)
    click_on "Edit this recipe duplication", match: :first

    click_on "Update Recipe duplication"

    assert_text "Recipe duplication was successfully updated"
    click_on "Back"
  end

  test "should destroy Recipe duplication" do
    visit recipe_duplication_url(@recipe_duplication)
    click_on "Destroy this recipe duplication", match: :first

    assert_text "Recipe duplication was successfully destroyed"
  end
end
