# frozen_string_literal: true

class EventsController < ApplicationController
  load_and_authorize_resource

  # GET /events
  def index
    @events = current_user.collaborable_events

    return unless params[:query].present?

    query = "%#{params[:query].downcase}%"
    @events = @events.where("LOWER(events.name) LIKE ?", query)
  end

  # GET /events/1
  def show
    @event = Event.includes(daily_plans: [ :day_tasks, daily_plan_recipes: :recipe ]).find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  def create
    current_user.events.new(event_params)

    if @event.save
      redirect_to @event, notice: "Event was successfully created."
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

  # DELETE /events/1
  def destroy
    @event.destroy!
    redirect_to events_url, notice: "Event was successfully destroyed.", status: :see_other
  end

  private

  # Only allow a list of trusted parameters through.
  def event_params
    params.fetch(:event, {}).permit(:name, :date_from, :date_to, :people_count)
  end
end
