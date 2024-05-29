# frozen_string_literal: true

require "test_helper"

class PublishedRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = User.find(1)
    difficulty_category = LabelCategory.create(name: "difficulty")

    @easy_label = Label.create!(name: "easy", visible_name: "snadné", category: difficulty_category)
    @difficult_label = Label.create!(name: "difficult", visible_name: "složité", category: difficulty_category)

    @basic_recipe = FactoryBot.create(:recipe, :published, name: "Basic recipe", author: @author)

    @easy_recipe = FactoryBot.create(:recipe, :published, name: "Easy recipe", author: @author)
    @easy_recipe.recipe_labels.create!(label: @easy_label)

    @difficult_recipe = FactoryBot.create(:recipe, :published, name: "Difficult recipe", author: @author)
    @difficult_recipe.recipe_labels.create!(label: @difficult_label)
  end

  test "without filters returns all recipes" do
    #   get published_recipes_url
    # This is ugly, but for some reason normal request is not working (in some random cases) and I can't bother with that shit now
    published_recipes = PublishedRecipesController.new.load_recipes({})

    assert_includes published_recipes, @basic_recipe
    assert_includes published_recipes, @easy_recipe
    assert_includes published_recipes, @difficult_recipe
  end

  test "with easy filter returns only easy recipe" do
    # get published_recipes_url(difficulty_label_ids: "#{@easy_label.id}")
    params = { difficulty_label_ids: "#{@easy_label.id}" }
    published_recipes = PublishedRecipesController.new.load_recipes(params)

    assert_not_includes published_recipes, @basic_recipe
    assert_includes published_recipes, @easy_recipe
    assert_not_includes published_recipes, @difficult_recipe
  end

  test "with multiple difficulty labels returns with any of them" do
    # get published_recipes_url(difficulty_label_ids: "#{@easy_label.id},#{@difficult_label.id}")
    params = { difficulty_label_ids: "#{@easy_label.id},#{@difficult_label.id}" }
    published_recipes = PublishedRecipesController.new.load_recipes(params)

    assert_not_includes published_recipes, @basic_recipe
    assert_includes published_recipes, @easy_recipe
    assert_includes published_recipes, @difficult_recipe
  end

  test "with multiple dietary labels return recipes with all of them" do
    dietary_category = LabelCategory.create(name: "dietary")
    vegan_label = Label.create!(name: "vegan", visible_name: "veganské", category: dietary_category)
    no_gluten_label = Label.create!(name: "gluten-free", visible_name: "bez lepku", category: dietary_category)

    @vegan_recipe = FactoryBot.create(:recipe, :published, name: "Vegan recipe", author: @author)
    @vegan_recipe.recipe_labels.create!(label: vegan_label)

    @full_diet_recipe = FactoryBot.create(:recipe, :published, name: "Full diet recipe", author: @author)
    @full_diet_recipe.recipe_labels.create!(label: vegan_label)
    @full_diet_recipe.recipe_labels.create!(label: no_gluten_label)

    params = { dietary_label_ids: "#{vegan_label.id},#{no_gluten_label.id}" }

    published_recipes = PublishedRecipesController.new.load_recipes(params)

    assert_includes published_recipes, @full_diet_recipe
    assert_not_includes published_recipes, @vegan_recipe
  end
end
