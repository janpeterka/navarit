# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :category, class_name: "IngredientCategory", optional: true
  belongs_to :measurement, optional: true
  belongs_to :author, class_name: "User", foreign_key: :created_by

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true

  scope :lasting, -> { where(is_lasting: true) }
  scope :used, -> { joins(:recipe_ingredients).where("recipe_ingredients.id IS NOT NULL").distinct.any? }
  scope :published, -> { where(is_public: true) }
  scope :not_published, -> { where(is_public: false) }

  delegate :lasting?, to: :category, allow_nil: true

  def name_with_unit
    if measurement.present?
      "#{name} (#{measurement.name})"
    else
      name
    end
  end

  def published?
    is_public
  end

  def deletable?
    return false if recipes.any?
    return false if published?

    true
  end

  def measurement_name
    return "" unless measurement.present?

    measurement.name
  end
end
