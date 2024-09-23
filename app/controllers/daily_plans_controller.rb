# frozen_string_literal: true

class DailyPlansController < ApplicationController
  before_action :set_daily_plan, only: %i[show edit update]
  authorize_resource :daily_plan

  def show
    @usable_recipes = [ [ "moje recepty",  current_user.recipes.collect { |v| [ v.name, v.id ] } ],
                        [ "oblíbené",  Recipe.liked_by(current_user).collect { |v| [ v.name, v.id ] } ],
                        [ "veřejné",  Recipe.published.collect { |v| [ v.name, v.id ] } ]
                      ]
  end

  def edit; end

  def update
    if @daily_plan.update(daily_plan_params)
      redirect_to @daily_plan, notice: "Daily plan was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def set_daily_plan
      @daily_plan = DailyPlan.find(params[:id])
    end

    def daily_plan_params
      params.fetch(:daily_plan, {})
    end
end
