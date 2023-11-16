# frozen_string_literal: true

FactoryBot.define do
  factory :hummus, class: Ingredient do
    id { 1 }
    name { 'Hummus' }
  end

  factory :carrot, class: Ingredient do
    id { 2 }
    name { 'Carrot' }
  end
end
