class UserRecipeReaction < ActiveRecord
  table_name "users_have_recipe_reactions"
  belongs_to :user
  belongs_to :recipe
end
