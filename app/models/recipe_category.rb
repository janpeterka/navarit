# frozen_string_literal: true

class RecipeCategory < ApplicationRecord
  has_many :recipes

  validates :name, presence: true, uniqueness: true

  scope :used, -> { joins(:recipes).where('recipes.id IS NOT NULL').distinct.any? }
end
