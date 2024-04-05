# frozen_string_literal: true

class RecipeLabel < ApplicationRecord
  self.table_name = "recipes_have_labels"

  belongs_to :recipe
  belongs_to :label
end
