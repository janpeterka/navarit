# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes
  def index
    @recipes = Current.user.recipes.includes(:category, :labels).order(:name)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @recipes = @recipes.where('LOWER(recipes.name) LIKE ? OR LOWER(recipe_categories.name) LIKE ?
                                          OR LOWER(labels.visible_name) LIKE ?',
                                query, query, query).references(:category, :labels)
    end

    @pagy, @recipes = pagy(@recipes)
  end

  # GET /recipes/1
  def show
    @portion_count = if params[:portion_count].present?
                       params[:portion_count].to_i
                     else
                       @recipe.portion_count
                     end

    @edited_section = params[:edited_section]&.to_sym
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe, edited_section: :ingredients)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'recept byl upraven.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy!
    redirect_to recipes_url, notice: 'recept byl smazán.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.fetch(:recipe, {}).permit(:name, :description, :category_id, :portion_count)
  end
end
