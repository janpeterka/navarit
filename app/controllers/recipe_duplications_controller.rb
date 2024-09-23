class RecipeDuplicationsController < ApplicationController
  def create
    original_recipe = Recipe.find(params[:recipe_id])
    authorize! :read, original_recipe

    recipe = original_recipe.duplicate(author: current_user)
    recipe.save!

    flash[:notice] = "recept byl úspěšně zkopírován."

    redirect_to recipe_path(recipe)
  end
end
