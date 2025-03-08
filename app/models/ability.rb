class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User

    can :read, Ingredient, is_public: true
    can :read, Recipe, is_shared: true
    can :read, Event, is_shared: true
    can :read, DailyPlan, event: { is_shared: true }

    return unless user.present?

    can :read, Event, id: user.viewable_events.pluck(:id)
    can :read, DailyPlan, event: { id: user.viewable_events.pluck(:id) }

    can %i[manage publish], Recipe, author: user

    can %i[manage publish], Ingredient, author: user

    can %i[manage publish archive unarchive], Event, author: user
    can %i[update archive unarchive], Event, id: user.collaborable_events.pluck(:id)
    cannot :archive, Event, is_archived: true
    cannot :update, Event, is_archived: true # Not sure why it cannot be in one line
    cannot :unarchive, Event, is_archived: false

    can %i[manage publish], DailyPlan, author: user
    can :update, DailyPlan, event: { id: user.collaborable_events.pluck(:id) }
    cannot :update, DailyPlan, event: { is_archived: true }

    can :manage, EventPortionType, author: user
    can :manage, PortionType, author: user
  end
end
