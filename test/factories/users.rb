# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    sequence(:email) { |n| "user-#{n}@navarit.cz" }
    password { "passwordpassword" }
    active { true }
    sequence(:fs_uniquifier) { |n| n }
  end
end
