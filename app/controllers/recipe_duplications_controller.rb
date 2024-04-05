# frozen_string_literal: true

class RecipeDuplicationsController < ApplicationController
  def create
    original_recipe = Recipe.find(params[:recipe_id])
    recipe = original_recipe.duplicate
    recipe.save!

    flash[:notice] = "recept byl úspěšně zkopírován."

    redirect_to recipe_path(recipe)
  end
end
