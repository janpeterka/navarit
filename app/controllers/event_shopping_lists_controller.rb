# frozen_string_literal: true

class EventShoppingListsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @shopping_list = EventShoppingList.new(@event)
  end
end
