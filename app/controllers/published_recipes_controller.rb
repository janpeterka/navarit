class PublishedRecipesController < ApplicationController
  before_action :set_published_recipe, only: %i[destroy]

  # GET /published_recipes
  def index
    @published_recipes = Recipe.published
  end

  # POST /published_recipes
  def create
    @published_recipe = PublishedRecipe.new(published_recipe_params)

    if @published_recipe.save
      redirect_to @published_recipe, notice: 'Published recipe was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /published_recipes/1
  def destroy
    @published_recipe.destroy!
    redirect_to published_recipes_url, notice: 'Published recipe was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_published_recipe
    @published_recipe = PublishedRecipe.find(params[:id])
  end
end
