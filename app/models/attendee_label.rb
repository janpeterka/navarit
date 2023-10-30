class AttendeeLabel < ApplicationRecord
  table_name = 'attendees_have_labels'

  belongs_to :attendee
  belongs_to :label
end
