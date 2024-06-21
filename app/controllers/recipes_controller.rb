class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[edit update destroy]
  authorize_resource

  def index
    @recipes = current_user.recipes.includes(:category, :labels, :ingredients).order(:name)

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @recipes = @recipes.where('LOWER(recipes.name) LIKE ? OR LOWER(recipe_categories.name) LIKE ?
                                          OR LOWER(labels.visible_name) LIKE ?',
                                query, query, query).references(:category, :labels)
    end

    @pagy, @recipes = pagy(@recipes)
  end

  def show
    @recipe = Recipe.includes(:tasks, ingredients: :measurement).find(params[:id])

    @portion_count = if params[:portion_count].present?
                      params[:portion_count].to_i
                     else
                      @recipe.portion_count
                     end

    @edited_section = params[:edited_section]&.to_sym if can? :edit, @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  # POST /recipes
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

  # DELETE /recipes/1
  def destroy
    @recipe.destroy!
    redirect_to recipes_url, notice: "recept byl smazán.", status: :see_other
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.fetch(:recipe, {}).permit(:name, :procedure, :category_id, :portion_count, :owner_sgid, :difficulty_label_ids,
                                     dietary_label_ids: [])
  end
end
