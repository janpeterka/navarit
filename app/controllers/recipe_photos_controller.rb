class RecipePhotosController < ApplicationController
  def destroy
    recipe = Recipe.find(params[:recipe_id])
    photo = recipe.photos.find(params[:id])

    return redirect_back_or_to recipe unless can? :edit, recipe

    photo.destroy
    flash[:notice] = "fotka smazána"

    redirect_back_or_to recipe
  end
end
