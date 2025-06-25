module Recipe::Prawnable
  extend ActiveSupport::Concern
  include RecipeIngredientsHelper
  include PrawnHelper

  def shrimpy_ingredients_table(document, daily_recipe:)
    document.text "suroviny:", style: :bold

    shrimpy_table(ingredients_table_data(daily_recipe), document:)

    document.move_down 10
  end

  private

    def ingredients_table_data(daily_recipe)
      ingredient_data = []
      daily_recipe.recipe.recipe_ingredients.includes(:ingredient).each do |recipe_ingredient|
        ingredient = recipe_ingredient.ingredient
        ingredient_data << [ ingredient.name,
                            formatted_amount_with_unit(recipe_ingredient,
                                                        daily_recipe.portion_count),
                            recipe_ingredient.comment ]
      end

      ingredient_data
    end
end
