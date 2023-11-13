# frozen_string_literal: true

class RecipeTask < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :name
end
