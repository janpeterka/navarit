# frozen_string_literal: true

class UserRecipeReaction < ApplicationRecord
  self.table_name = 'users_have_recipes_reaction'

  belongs_to :user
  belongs_to :recipe
  # TODO: add users.user_recipe_reactions_count
  # belongs_to :recipe, counter_cache: true

  validates :user, uniqueness: { scope: :recipe }
end
