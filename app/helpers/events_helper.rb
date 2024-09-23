# frozen_string_literal: true

module EventsHelper
  def event_collaboration_icon(event)
    if event.role_for(current_user) == :viewer
      icon(:eye, class: "ml-2 text-ocean-500")
    elsif event.role_for(current_user) == :collaborator
      icon("users-three", class: "ml-2 text-ocean-500")
    end
  end
end
