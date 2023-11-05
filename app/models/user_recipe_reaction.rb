# frozen_string_literal: true

class UserRecipeReaction < ApplicationRecord
  self.table_name = 'users_have_recipes_reaction'

  belongs_to :user
  belongs_to :recipe
end
