class EventCollaborationController < ApplicationController
  before_action :load_event, only: %i[index create destroy]

  def index
    @event = current_user.collaborable_events.find(params[:event_id])
  end

  def create
    return unless can? :update, @event

    user = User.find_by(email: params[:email])

    if @event.add_collaborator(user, permission: params[:permission])
      flash[:notice] = "přidáno!"
      redirect_to event_collaboration_index_path(@event)
    else
      flash[:error] = "něco se nepovedlo"
      redirect_to event_collaboration_index_path(@event)
    end
  end

  def destroy
    return unless can? :update, @event

    role = @event.user_event_roles.find_by(user_id: params[:id].to_i)
    role.destroy

    redirect_to event_collaboration_index_path(@event)
  end

  private

  def load_event
    @event = current_user.collaborable_events.find(params[:event_id])
  end
end
