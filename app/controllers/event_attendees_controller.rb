# frozen_string_literal: true

class EventAttendeesController < ApplicationController
  before_action :set_event
  before_action :set_event_attendee, only: %i[show edit update destroy]

  def index
    @event_attendees = @event.attendees
  end

  def show; end

  def new
    @event_attendee = EventAttendee.new
  end

  def edit; end

  def create
    authorize! :update, @event

    @event_attendee = EventAttendee.new(event_attendee_params)

    if @event_attendee.save
      redirect_to @event_attendee, notice: "Event attendee was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, @event

    if @event_attendee.update(event_attendee_params)
      redirect_to @event_attendee, notice: "Event attendee was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :update, @event

    @event_attendee.destroy!

    redirect_to event_attendees_url, notice: "Event attendee was successfully destroyed.", status: :see_other
  end

  private

    def set_event_attendee
      @event_attendee = EventAttendee.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def event_attendee_params
      params.fetch(:event_attendee, {})
    end
end
