# frozen_string_literal: true

class EventCookbooksController < ApplicationController
  before_action :load_event

  def show
    authorize! :show, @event

    @cookbook = EventCookbook.new(@event)

    respond_to do |format|
      format.html
      format.pdf do
        send_data @cookbook.pdf.render,
                  filename: "#{@event.name.underscore.gsub(' ', '_')}_cookbook.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  private

    def load_event
      @event = Event.find(params[:event_id])
    end
end
