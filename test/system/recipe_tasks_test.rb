require "application_system_test_case"

class RecipeTasksTest < ApplicationSystemTestCase
  setup do
    @recipe_task = recipe_tasks(:one)
  end

  test "visiting the index" do
    visit recipe_tasks_url
    assert_selector "h1", text: "Recipe tasks"
  end

  test "should create recipe task" do
    visit recipe_tasks_url
    click_on "New recipe task"

    click_on "Create Recipe task"

    assert_text "Recipe task was successfully created"
    click_on "Back"
  end

  test "should update Recipe task" do
    visit recipe_task_url(@recipe_task)
    click_on "Edit this recipe task", match: :first

    click_on "Update Recipe task"

    assert_text "Recipe task was successfully updated"
    click_on "Back"
  end

  test "should destroy Recipe task" do
    visit recipe_task_url(@recipe_task)
    click_on "Destroy this recipe task", match: :first

    assert_text "Recipe task was successfully destroyed"
  end
end
