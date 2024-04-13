# frozen_string_literal: true

class DailyPlansController < ApplicationController
  before_action :set_daily_plan, only: %i[show edit update]
  authorize_resource :daily_plan

  # GET /daily_plans
  # def index
  #   @daily_plans = DailyPlan.all
  # end

  # GET /daily_plans/1
  def show; end

  # # GET /daily_plans/new
  # def new
  #   @daily_plan = DailyPlan.new
  # end

  # GET /daily_plans/1/edit
  def edit; end

  # # POST /daily_plans
  # def create
  #   @daily_plan = DailyPlan.new(daily_plan_params)

  #   if @daily_plan.save
  #     redirect_to @daily_plan, notice: 'Daily plan was successfully created.'
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /daily_plans/1
  def update
    if @daily_plan.update(daily_plan_params)
      redirect_to @daily_plan, notice: "Daily plan was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_plan
    @daily_plan = DailyPlan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def daily_plan_params
    params.fetch(:daily_plan, {})
  end
end
