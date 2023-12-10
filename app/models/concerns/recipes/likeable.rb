# frozen_string_literal: true

module Recipes
  module Likeable
    extend ActiveSupport::Concern

    included do
      has_many :reactions, class_name: 'UserRecipeReaction', dependent: :destroy

      scope :liked_by, ->(user) { joins(:reactions).where('users_have_recipes_reaction.user_id = ?', user.id) }
    end

    def liked_by?(user)
      reactions.where(user:).any?
    end

    def like!(user)
      reactions.create(user:)
    end

    def unlike!(user)
      reactions.where(user:).destroy_all
    end
  end
end
