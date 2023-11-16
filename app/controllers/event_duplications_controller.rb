# frozen_string_literal: true

class EventDuplicationsController < ApplicationController
  def create
    original_event = Event.find(params[:event_id])
    event = original_event.duplicate
    event.save!

    flash[:notice] = 'akce byla úspěšně zkopírována.'

    redirect_to event_path(event)
  end
end
