# frozen_string_literal: true

FactoryBot.define do
  factory :hummus_with_carrot, class: Recipe do
    id { 1 }
    name { "Hummus with carrot" }
    portion_count { 3 }
    created_by { 1 }
    ingredients { [ FactoryBot.build(:hummus), FactoryBot.build(:carrot) ] }
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
