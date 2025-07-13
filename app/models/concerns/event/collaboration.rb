module Event::Collaboration
  extend ActiveSupport::Concern

  included do
    has_many :user_event_roles
    has_many :collaborators, through: :user_event_roles, source: :user
  end

  def involved_users
    [ author ] + collaborators
  end

  def role_for(user)
    if user == author
      :author
    elsif (user_event_role = user_event_roles.find_by(user:)).present?
      user_event_role.role.to_sym
    elsif user.admin?
      :admin
    end
  end

  def add_collaborator(user, permission: :viewer)
    return false unless user.present?
    return true if user == author

    user_event_roles.create(user:, role: permission)
  end
end
