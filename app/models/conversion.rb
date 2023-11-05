# frozen_string_literal: true

class Conversion < ApplicationRecord
  self.table_name = 'measurements_to_measurements'

  belongs_to :ingredient
  belongs_to :target_measurement, class_name: 'Measurement'

  validates :amount_from, presence: true
  validates :amount_to, presence: true
end
