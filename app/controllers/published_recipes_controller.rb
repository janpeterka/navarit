# frozen_string_literal: true

class PublishedRecipesController < ApplicationController
  def index
    # @published_recipes = Recipe.published.includes(:category, :labels, :reactions)
    @published_recipes = Recipe.published.includes(:category, :labels)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @published_recipes = @published_recipes.where('LOWER(recipes.name) LIKE ? OR LOWER(recipe_categories.name) LIKE ? OR LOWER(labels.visible_name) LIKE ?',
                                                    query, query, query).references(:category, :labels)
    end

    # @pagy, @recipes = pagy(@recipes)

    # @published_recipes = @published_recipes.where(category: params[:category]) if params[:category].present?
    # @published_recipes = @published_recipes.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?

    # TODO: this will make trouble with pagination, probably will need to be solved by adding counter cache to reactions
    @published_recipes = @published_recipes.sort_by { _1.reactions.count }.reverse
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
