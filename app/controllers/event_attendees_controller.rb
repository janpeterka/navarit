# frozen_string_literal: true

class EventAttendeesController < ApplicationController
  before_action :set_event
  before_action :set_event_attendee, only: %i[show edit update destroy]

  # GET /event_attendees
  def index
    @event_attendees = @event.attendees
  end

  # GET /event_attendees/1
  def show; end

  # GET /event_attendees/new
  def new
    @event_attendee = EventAttendee.new
  end

  # GET /event_attendees/1/edit
  def edit; end

  # POST /event_attendees
  def create
    @event_attendee = EventAttendee.new(event_attendee_params)

    if @event_attendee.save
      redirect_to @event_attendee, notice: 'Event attendee was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_attendees/1
  def update
    if @event_attendee.update(event_attendee_params)
      redirect_to @event_attendee, notice: 'Event attendee was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /event_attendees/1
  def destroy
    @event_attendee.destroy!
    redirect_to event_attendees_url, notice: 'Event attendee was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event_attendee
    @event_attendee = EventAttendee.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  # Only allow a list of trusted parameters through.
  def event_attendee_params
    params.fetch(:event_attendee, {})
  end
end
