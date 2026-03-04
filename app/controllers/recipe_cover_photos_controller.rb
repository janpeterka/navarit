class RecipeCoverPhotosController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])

    return redirect_back_or_to recipe unless can? :edit, recipe

    photo = recipe.photos.find(params[:id])
    recipe.update(cover_photo: photo)

    redirect_back_or_to recipe
  end
end
