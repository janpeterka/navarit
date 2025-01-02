class UserRecipeReaction < ApplicationRecord
  self.table_name = "users_have_recipes_reaction"

  belongs_to :user
  belongs_to :recipe, counter_cache: :reactions_count

  validates :user, uniqueness: { scope: :recipe }
end
