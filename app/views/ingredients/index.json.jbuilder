# frozen_string_literal: true

json.array! @ingredients, partial: 'ingredients/ingredient', as: :ingredient
