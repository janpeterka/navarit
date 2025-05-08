class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[edit update destroy]
  authorize_resource

  def index
    @recipes = current_user.recipes.includes(:category, :labels, :ingredients).order(:name)

    @recipes = @recipes.search(params[:query]) if params[:query].present?

    @pagy, @recipes = pagy(@recipes)
  end

  def show
    @recipe = Recipe.includes(:tasks, ingredients: :measurement).find(params[:id])

    authorize! :show, @recipe

    @portion_count = params[:portion_count].presence&.to_i || @recipe.portion_count

    @edited_section = params[:edited_section]&.to_sym if can? :edit, @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe, edited_section: :ingredients)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "recept byl upraven.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy!
    redirect_to recipes_url, notice: "recept byl smazán.", status: :see_other
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.fetch(:recipe, {}).permit(:name, :procedure, :category_id, :portion_count, :difficulty_label_ids,
                                      dietary_label_ids: [], photos: [])
    end
end
