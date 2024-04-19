class DailyPlanRecipesController < ApplicationController
  before_action :set_daily_plan_recipe, only: %i[show edit update destroy]
  before_action :set_daily_plan, only: %i[create]

  def create
    unless can? :update, @daily_plan
      flash[:error] = "Nemáte oprávnění přidat recept do tohoto plánu"
      return redirect_back_or_to @daily_plan
    end

    @daily_plan_recipe = @daily_plan.daily_plan_recipes.new(daily_plan_recipe_params.merge(recipe_id: params[:recipe_id]))

    unless @daily_plan_recipe.save
      flash[:error] = "recept nebyl přidán: #{@daily_plan_recipe.errors.full_messages.join(', ')}"
    end

    redirect_back_or_to @daily_plan_recipe.daily_plan
  end

  def update
    unless can? :update, @daily_plan_recipe.daily_plan
      flash[:error] = "Nemáte oprávnění upravit recept"
      return redirect_back_or_to @daily_plan_recipe.daily_plan
    end

    if @daily_plan_recipe.update(daily_plan_recipe_params)
      redirect_back_or_to @daily_plan_recipe.daily_plan, notice: "recept upraven."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless can? :update, @daily_plan_recipe.daily_plan
      flash[:error] = "Nemáte oprávnění přidat recept do tohoto plánu"
      return redirect_back_or_to @daily_plan_recipe.daily_plan
    end

    @daily_plan_recipe.destroy

    redirect_back_or_to @daily_plan_recipe.daily_plan, notice: "recept byl odebrán"
  end

  def sort
    daily_plan_recipe = DailyPlanRecipe.find(params[:daily_plan_recipe_id])

    unless can? :update, daily_plan_recipe.daily_plan
      flash[:error] = "Nemáte oprávnění přesunout recept v tomto plánu"
      return redirect_back_or_to daily_plan_recipe.daily_plan
    end

    new_position = params[:position].to_i

    daily_plan_recipe.insert_at(new_position)
  end

  def move
    daily_plan_recipe = DailyPlanRecipe.find(params[:daily_plan_recipe_id])

    unless can? :update, daily_plan_recipe.daily_plan
      flash[:error] = "Nemáte oprávnění přesunout recept v tomto plánu"
      return redirect_back_or_to ddaily_plan_recipe.daily_plan
    end

    new_plan = DailyPlan.find(params[:daily_plan_id])
    new_position = params[:position].to_i

    daily_plan_recipe.remove_from_list
    daily_plan_recipe.update(daily_plan: new_plan)
    daily_plan_recipe.insert_at(new_position)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_plan_recipe
    @daily_plan_recipe = DailyPlanRecipe.find(params[:id])
  end

  def set_daily_plan
    @daily_plan = DailyPlan.find(params[:daily_plan_id])
  end

  # Only allow a list of trusted parameters through.
  def daily_plan_recipe_params
    params.fetch(:daily_plan_recipe, params)
          .permit(:daily_plan_id, :meal_type, :portion_count)
          .transform_values(&:presence).transform_values { _1&.strip }
  end
end
