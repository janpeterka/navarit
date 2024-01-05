# frozen_string_literal: true

module Event::HasPortionTypes
  include ActiveSupport::Concern

  def portion_type_attendee_count
    event_portion_types.sum(:count)
  end

  def portion_type_remaining_attendee_count
    people_count - portion_type_attendee_count
  end

  def portion_count
    portion_count = 0
    accounted_for_count = 0
    event_portion_types.each do |ept|
      portion_count += ept.portion_type.size * ept.count
      accounted_for_count += ept.count
    end

    portion_count += (people_count - accounted_for_count) if people_count > accounted_for_count
    portion_count
  end
end
