# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    id { 1 }
    name { 'Random event' }
    people_count { 5 }
    created_by { Current.user.id }
    date_from { 3.days.from_now.to_date }
    date_to { 5.days.from_now.to_date }
  end

  factory :event_with_shoppings, class: Event do
    id { 2 }
    name { 'Event with shoppings' }
    people_count { 5 }
    created_by { Current.user.id }
    date_from { 3.days.from_now.to_date }
    date_to { 12.days.from_now.to_date }
  end
end
