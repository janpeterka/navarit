# frozen_string_literal: true

class EventPortionType < ApplicationRecord
  self.table_name = 'event_has_portion_type'

  belongs_to :event
  belongs_to :portion_type

  validates :count, presence: true
end
