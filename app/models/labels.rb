class Label < ApplicationRecord
  belongs_to :category, class_name: "LabelCategory"

  validates :name, presence: true, uniqueness: true
  validates :visible_name, presence: true, uniqueness: true

  scope :of_category, ->(category) { joins(:category).where("label_categories.name = ?", category) }
end
