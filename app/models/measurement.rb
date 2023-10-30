class Measurement < ActiveRecord
  has_many :ingredients
  has_many :conversions, class_name: "MeasurementConversion", foreign_key: "from_measurement_id"

  validates :name, presence: true, uniqueness: true

  scope :used, -> { joins(:ingredients).where("ingredients.id IS NOT NULL").distinct.any? }
end
