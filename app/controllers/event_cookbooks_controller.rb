# frozen_string_literal: true

class EventCookbooksController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @cookbook = EventCookbook.new(@event)
  end
end
