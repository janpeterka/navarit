class RecipeTask < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
  validates :days_before_cooking, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :set_default_days

  private

    def set_default_days
      return if days_before_cooking.present?

      self.days_before_cooking = 0
    end
end
