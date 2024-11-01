class EventShoppingListsController < ApplicationController
  before_action :load_event

  def show
    authorize! :show, @event

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

  private

    def load_event
      @event = Event.find(params[:event_id])
    end
end
