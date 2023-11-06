# frozen_string_literal: true

class PublishedRecipesController < ApplicationController
  def index
    @published_recipe = Recipe.new
    @published_recipes = Recipe.published

    @published_recipes = @published_recipes.where(category: params[:category]) if params[:category].present?
    @published_recipes = @published_recipes.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
  end

  def create
    recipe = Recipe.find(params[:recipe_id])

    if recipe.publish!
      flash[:notice] = 'recept byl zveřejněn'
    else
      flash[:error] = 'recept nebyl zveřejněn'
    end

    redirect_back_or_to recipe
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.unpublish!

    redirect_back_or_to recipe, notice: 'recept byl zneveřejněn'
  end

  private

  def set_published_recipe; end
end
