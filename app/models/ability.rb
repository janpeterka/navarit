# frozen_string_literal: true

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

    # can :read, :all, author: user
    can %i[manage publish], Recipe, author: user
    can %i[manage publish], Ingredient, author: user
    can %i[manage publish], Event, author: user
    can %i[manage publish], DailyPlan, author: user
  end
end
