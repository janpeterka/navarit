# frozen_string_literal: true

class Attendee < ApplicationRecord
  belongs_to :event
  belongs_to :portion_type

  has_many :attendee_labels
  has_many :labels, through: :attendee_labels

  validates :name, presence: true

  scope :with_portion_type, ->(portion_type) { joins(:portion_type).where("portion_types.name = ?", portion_type) }
end
