# frozen_string_literal: true

class DailyPlanTasksController < ApplicationController
  before_action :set_daily_plan_task, only: %i[show edit update destroy]

  # GET /daily_plan_tasks
  def index
    @daily_plan_tasks = DailyPlanTask.all
  end

  # GET /daily_plan_tasks/1
  def show; end

  # GET /daily_plan_tasks/new
  def new
    @daily_plan_task = DailyPlanTask.new
  end

  # GET /daily_plan_tasks/1/edit
  def edit; end

  # POST /daily_plan_tasks
  def create
    @daily_plan_task = DailyPlanTask.new(daily_plan_task_params)

    flash[:error] = @daily_plan_task.errors.full_messages.to_sentence unless @daily_plan_task.save

    redirect_back_or_to @daily_plan_task.daily_plan
  end

  # PATCH/PUT /daily_plan_tasks/1
  def update
    if @daily_plan_task.update(daily_plan_task_params)
      flash[:notice] = "Daily plan task was successfully updated."
    else
      flash[:error] = @daily_plan_task.errors.full_messages.to_sentence
    end

    redirect_back_or_to @daily_plan_task.daily_plan
  end

  # DELETE /daily_plan_tasks/1
  def destroy
    @daily_plan_task.destroy!
    redirect_back_or_to @daily_plan_task.daily_plan, status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_plan_task
    @daily_plan_task = DailyPlanTask.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def daily_plan_task_params
    params.fetch(:daily_plan_task, params).permit(:daily_plan_id, :name, :description, :status)
  end
end
