# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'user@navarit.cz' }
    active { true }
    fs_uniquifier { '1234567890' }
  end
end
