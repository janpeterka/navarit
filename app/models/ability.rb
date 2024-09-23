class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User

    can :read, Ingredient, is_public: true
    can :read, Recipe, is_shared: true
    can :read, Event, is_shared: true

    can :read, DailyPlan, event: { is_shared: true }

    return unless user.present?

    can :read, Event, id: user.events_in_role.pluck(:id)
    can :read, DailyPlan, event: { id: user.events_in_role.pluck(:id) }

    can %i[manage publish], Recipe, author: user

    can %i[manage publish], Ingredient, author: user

    can %i[manage publish archive unarchive], Event, author: user
    can %i[update archive unarchive], Event, id: UserEventRole.where(user_id: user.id, role: "collaborator").pluck(:event_id)
    cannot :archive, Event, is_archived: true
    cannot %i[update], Event, is_archived: true
    cannot :unarchive, Event, is_archived: false

    can %i[manage publish], DailyPlan, author: user
    cannot %i[update], DailyPlan, event: { is_archived: true }
    can %i[update], DailyPlan, event: { id: UserEventRole.where(user_id: user.id, role: "collaborator").pluck(:event_id) }

    can :manage, EventPortionType, author: user
  end
end
