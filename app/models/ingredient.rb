# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :category, class_name: 'IngredientCategory'
  belongs_to :measurement
  belongs_to :author, class_name: 'User', foreign_key: :created_by

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true

  scope :lasting, -> { where(is_lasting: true) }
  scope :used, -> { joins(:recipe_ingredients).where('recipe_ingredients.id IS NOT NULL').distinct.any? }
  scope :published, -> { where(is_public: true) }
end
