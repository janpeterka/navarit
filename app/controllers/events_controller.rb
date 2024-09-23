# frozen_string_literal: true

class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @events = current_user.collaborable_events.search(params[:query]).order(date_to: :desc)
  end

  def show
    @event = Event.includes(daily_plans: [ :day_tasks, daily_plan_recipes: :recipe ]).find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    current_user.events.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, status: :see_other, notice: "akce byla upravena"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!

    redirect_to events_url, notice: "akce byla smazána", status: :see_other
  end

  private

    def event_params
      params.fetch(:event, {}).permit(:name, :date_from, :date_to, :people_count)
    end
end
