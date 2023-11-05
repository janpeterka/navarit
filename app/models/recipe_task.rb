# frozen_string_literal: true

class RecipeTask < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
end
