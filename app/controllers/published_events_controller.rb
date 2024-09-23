# frozen_string_literal: true

class PublishedEventsController < PublicApplicationController
  before_action :set_event, only: %i[create destroy]

  def show
    @event = Event.load_from_hash(params[:id])

    return unless current_user.present? && can?(:read, @event)

    redirect_to @event
  end

  def create
    authorize! :publish, @event

    @event.publish!
    flash[:notice] = "akce byla zveřejněna"

    redirect_to event_collaboration_index_path(@event), status: :see_other
  end

  def destroy
    authorize! :publish, @event

    @event.unpublish!
    flash[:notice] = "akce byla skryta"

    redirect_to event_collaboration_index_path(@event), status: :see_other
  end

  private

    def set_event
      if params[:id].present?
        @event = Event.find(params[:id])
      elsif params[:event_id].present?
        @event = Event.find(params[:event_id])
      end
    end
end
