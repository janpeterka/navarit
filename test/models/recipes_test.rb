require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = FactoryBot.build(:hummus_with_carrot, author: User.find(1))
    @recipe.tasks.new(name: "task 1")
  end


  test "duplication" do
    another_user = FactoryBot.create(:user, id: 100)
    new_recipe = @recipe.duplicate(author: another_user)

    assert_equal new_recipe.name, "#{@recipe.name} (kopie)"
    assert_not_equal new_recipe.id, @recipe.id
    assert_equal new_recipe.author, another_user

    # TODO: test tasks, recipe_labels, recipe_ingredients
    assert @recipe.tasks.size == 1
    assert_equal new_recipe.tasks.size, @recipe.tasks.size
    # assert @recipe.recipe_labels.size == 2
    # assert_equal new_recipe.recipe_labels, @recipe.recipe_labels
    assert @recipe.recipe_ingredients.size == 2
    assert_equal new_recipe.recipe_ingredients.size, @recipe.recipe_ingredients.size
  end
end
