class EventCollaborationController < ApplicationController
  before_action :load_event, only: %i[index create update destroy]

  def index
    @event = current_user.collaborable_events.find(params[:event_id])
  end

  def create
    return unless can? :update, @event

    user = User.find_by(email: params[:email])

    if @event.add_collaborator(user, permission: params[:permission])
      flash[:notice] = "přidáno!"
    else
      flash[:error] = "něco se nepovedlo"
    end

    redirect_to event_collaboration_index_path(@event)
  end

  def update
    role = @event.user_event_roles.find_by(user_id: params[:id])
    role.update(role: params[:option].to_sym)

    redirect_to event_collaboration_index_path(@event)
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
