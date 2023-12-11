# frozen_string_literal: true

class PublishedEventsController < PublicApplicationController
  before_action :set_event, only: %i[create destroy]

  def show
    @event = Event.load_from_hash(params[:id])

    return unless current_user.present? && can?(:read, @event)

    redirect_to @event
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
