# frozen_string_literal: true

class DailyPlanRecipesController < ApplicationController
  before_action :set_daily_plan_recipe, only: %i[show edit update destroy]

  # GET /daily_plan_recipes
  def index
    @daily_plan_recipes = DailyPlanRecipe.all
  end

  # GET /daily_plan_recipes/1
  def show; end

  # GET /daily_plan_recipes/new
  def new
    @daily_plan_recipe = DailyPlanRecipe.new
  end

  # GET /daily_plan_recipes/1/edit
  def edit; end

  # POST /daily_plan_recipes
  def create
    @daily_plan_recipe = DailyPlanRecipe.new(daily_plan_recipe_params)
    @daily_plan_recipe.set_position

    unless @daily_plan_recipe.save
      flash[:error] = "recept nebyl přidán: #{@daily_plan_recipe.errors.full_messages.join(', ')}"
    end

    redirect_back_or_to @daily_plan_recipe.daily_plan
  end

  def update
    if @daily_plan_recipe.update(daily_plan_recipe_params)
      redirect_back_or_to @daily_plan_recipe.daily_plan, notice: 'Daily plan recipe was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /daily_plan_recipes/1
  def destroy
    @daily_plan_recipe.destroy!
    @daily_plan_recipe.normalize_order_indices

    redirect_back_or_to @daily_plan_recipe.daily_plan, notice: 'recept byl odebrán'
  end

  def sort
    daily_plan_recipe = DailyPlanRecipe.find(params[:daily_plan_recipe_id])
    new_position = params[:position].to_i

    daily_plan_recipe.sort_to(new_position)
  end

  def move
    daily_plan_recipe = DailyPlanRecipe.find(params[:daily_plan_recipe_id])
    new_plan = DailyPlan.find(params[:daily_plan_id])
    new_position = params[:position].to_i

    daily_plan_recipe.update!(daily_plan: new_plan)
    # daily_plan_recipe.sort_to(new_position)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_plan_recipe
    @daily_plan_recipe = DailyPlanRecipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def daily_plan_recipe_params
    params.fetch(:daily_plan_recipe, params)
          .permit(:daily_plan_id, :recipe_id, :meal_type, :portion_count)
          .transform_values(&:presence).transform_values { _1&.strip }
  end
end
