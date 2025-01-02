# frozen_string_literal: true

class IngredientCategory < ApplicationRecord
  has_many :ingredients

  validates :name, presence: true

  scope :lasting, -> { where(is_lasting: true) }
  scope :used, -> { joins(:ingredients).where("ingredients.id IS NOT NULL").distinct.any? }

  def lasting? = is_lasting
end
