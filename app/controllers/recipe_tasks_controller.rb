class RecipeTasksController < ApplicationController
  before_action :set_recipe_task, only: %i[show edit update destroy]
  before_action :set_recipe, only: %i[index]

  # GET /recipe_tasks
  def index
    @recipe_tasks = RecipeTask.all
  end

  # GET /recipe_tasks/1
  def show; end

  # GET /recipe_tasks/new
  def new
    @recipe_task = RecipeTask.new
  end

  # GET /recipe_tasks/1/edit
  def edit; end

  # POST /recipe_tasks
  def create
    @recipe_task = RecipeTask.new(recipe_task_params)

    flash[:error] = 'něco se nepovedlo' unless @recipe_task.save

    redirect_back_or_to @recipe_task.recipe
  end

  # PATCH/PUT /recipe_tasks/1
  def update
    if @recipe_task.update(recipe_task_params)
      flash[:notice] = 'úkol upraven'
    else
      flash[:error] = 'něco se nepovedlo'
    end

    redirect_back_or_to @recipe_task.recipe
  end

  # DELETE /recipe_tasks/1
  def destroy
    @recipe_task.destroy!

    redirect_back_or_to @recipe_task.recipe
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_task
    @recipe_task = RecipeTask.find(params[:id])
  end

  def set_recipe
    @recipe = if params[:recipe_id].present?
                Recipe.find(params[:recipe_id])
              else
                @recipe_task.recipe
              end
  end

  # Only allow a list of trusted parameters through.
  def recipe_task_params
    params.fetch(:recipe_task, params).permit(:name, :description, :days_before_cooking, :recipe_id)
  end
end
