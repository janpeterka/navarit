# frozen_string_literal: true

class PublishedEventsController < ApplicationController
  before_action :set_event, only: %i[create destroy]

  # GET /events
  def index
    @events = current_user.events
  end

  # POST /events
  def create
    @event.publish!
    flash[:notice] = 'akce byla zveřejněna'

    redirect_back_or_to @event
  end

  # DELETE /events/1
  def destroy
    @event.unpublish!
    flash[:notice] = 'akce byla skryta'

    redirect_back_or_to @event
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    if params[:id].present?
      @event = Event.find(params[:id])
    elsif params[:event_id].present?
      @event = Event.find(params[:event_id])
    end
  end
end
