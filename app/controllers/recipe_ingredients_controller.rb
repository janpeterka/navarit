class RecipeIngredientsController < ApplicationController
  before_action :set_recipe_ingredient, only: %i[show edit update destroy]
  before_action :set_recipe, only: %i[index create update]

  def index
    @recipe_ingredients = @recipe.recipe_ingredients.sort_by(&:recipe_amount).reverse
  end

  def show; end

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def edit; end

  def create
    authorize! :update, @recipe

    @recipe_ingredient = RecipeIngredient.new(updated_params)

    flash[:error] = "nepovedlo se přidat surovinu" unless @recipe_ingredient.save

    redirect_back_or_to recipe_path(@recipe)
  end

  def update
    authorize! :update, @recipe

    if @recipe_ingredient.update(updated_params)
      flash[:notice] = "upraveno"
    else
      flash[:error] = "nepovedlo se upravit surovinu"
    end

    redirect_back_or_to recipe_path(@recipe)
  end

  def destroy
    authorize! :update, @recipe

    @recipe_ingredient.destroy!

    redirect_back_or_to recipe_path(@recipe_ingredient.recipe), status: :see_other
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_ingredient
      # TODO: add id to RecipeIngredient
      recipe_id, ingredient_id = params[:id].split("_")
      @recipe_ingredient = RecipeIngredient.where(recipe_id:, ingredient_id:).first
    end

    def set_recipe
      if params[:recipe_id].present?
        @recipe = Recipe.find(params[:recipe_id])
      elsif @recipe_ingredient.present?
        @recipe = @recipe_ingredient.recipe
      end
    end

    # Only allow a list of trusted parameters through.
    def recipe_ingredient_params
      params.fetch(:recipe_ingredient, params).permit(:recipe_id, :ingredient_id, :amount, :comment)
            .transform_values(&:presence).transform_values { _1&.strip }
    end

    def updated_params
      recipe_ingredient_params.merge({
                                      amount: recipe_ingredient_params[:amount].to_f / @recipe.portion_count
                                    })
    end
end
