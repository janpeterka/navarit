# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User
    can :read, Recipe, is_shared: true
    can :read, Ingredient, is_public: true
    can :read, Event, is_shared: true

    return unless user.present?

    can :read, :all, author: user
    can %i[manage publish], :all, author: user
  end
end
