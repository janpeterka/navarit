# frozen_string_literal: true

class EventDuplicationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    original_event = Event.find(params[:event_id])
    date_offset = (event_params[:date_from] - original_event.date_from).to_i

    new_date_to = original_event.date_to + date_offset

    event = Event.new(event_params.merge(date_to: new_date_to, name: "#{original_event.name} (kopie)"))
    event.save

    original_event.duplicate_into(event)
    event.save

    flash[:notice] = 'akce byla úspěšně zkopírována.'

    redirect_to event_path(event)
  end

  def event_params
    event_params = params.fetch(:event, {}).permit(:people_count, :date_from, :name)
    event_params.merge(date_from: Date.new(event_params['date_from(1i)'].to_i, event_params['date_from(2i)'].to_i,
                                           event_params['date_from(3i)'].to_i))
  end
end
