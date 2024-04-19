# frozen_string_literal: true

class AttendeeLabel < ApplicationRecord
  self.table_name = "attendees_have_labels"

  belongs_to :attendee
  belongs_to :label
end
