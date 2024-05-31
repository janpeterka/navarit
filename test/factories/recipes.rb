# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Recipe ##{n}" }
    portion_count { 10 }
    author { FactoryBot.build(:user) }

    trait :published do
      is_shared { true }
    end
  end

  factory :hummus_with_carrot, class: Recipe do
    id { 1 }
    name { "Hummus with carrot" }
    portion_count { 3 }
    created_by { 1 }
    ingredients { [ FactoryBot.build(:hummus, author:), FactoryBot.build(:carrot, author:) ] }
    after(:build) do |recipe|
      recipe.recipe_ingredients.each do |ri|
        ri.amount = 1
      end
    end
  end

  factory :shopping, class: Recipe do
    id { 167 }
    name { "Shopping" }
    created_by { 1 }
    portion_count { 1 }
  end
end
