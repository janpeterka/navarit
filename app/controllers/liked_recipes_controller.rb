class LikedRecipesController < ApplicationController
  def index
    @liked_recipes = Recipe.liked_by(Current.user)
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    recipe.like!

    redirect_to request.referrer
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.unlike!

    redirect_to request.referrer
  end
end
