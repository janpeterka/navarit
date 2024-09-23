class EventCollaborationController < ApplicationController
  before_action :load_event, only: %i[index create update destroy]

  def index; end

  def create
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
    role = @event.user_event_roles.find_by(user_id: params[:id].to_i)
    role.destroy

    redirect_to event_collaboration_index_path(@event)
  end

  private

    def load_event
      @event = current_user.viewable_events.find(params[:event_id])
      authorize! :manage, @event
    end
end
