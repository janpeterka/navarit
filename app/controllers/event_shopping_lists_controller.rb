# frozen_string_literal: true

class EventShoppingListsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @shopping_list = EventShoppingList.new(@event)

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #   end
    # end
  end
end
