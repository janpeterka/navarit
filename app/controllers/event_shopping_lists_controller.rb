# frozen_string_literal: true

class EventShoppingListsController < ApplicationController
  def show
    authorize! :show, @event

    @event = Event.find(params[:event_id])
    @shopping_list = EventShoppingList.new(@event)

    respond_to do |format|
      format.html
      format.pdf do
        send_data @shopping_list.pdf.render,
                  filename: "#{@event.name.underscore.gsub(' ', '_')}_shopping_list.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end
end
