# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    id { 1 }
    name { "Random event" }
    created_by { 1 }
    people_count { 5 }
    date_from { 3.days.from_now.to_date }
    date_to { 5.days.from_now.to_date }
    is_archived { false }
  end

  factory :event_with_shoppings, class: Event do
    id { 2 }
    name { "Event with shoppings" }
    created_by { 1 }
    people_count { 5 }
    date_from { 3.days.from_now.to_date }
    date_to { 12.days.from_now.to_date }
  end
end
