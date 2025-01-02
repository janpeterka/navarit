class RecipePhotosController < ApplicationController
  def destroy
    recipe = Recipe.find(params[:recipe_id])
    photo = recipe.photos.find(params[:id])

    return unless can? :edit, recipe

    photo.destroy
    flash[:notice] = "fotka smazána"

    redirect_back_or_to recipe
  end
end
