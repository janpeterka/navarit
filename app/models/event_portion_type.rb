class EventPortionType < ApplicationRecord
  self.table_name = 'event_has_portion_type'

  belongs_to :event
  belongs_to :portion_type

  has_many :attendees, through: :event, scope: -> { with_portion_type(portion_type.name) }

  validates :count, presence: true, default: 0
end
