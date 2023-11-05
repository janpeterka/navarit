# frozen_string_literal: true

json.extract! ingredient, :id, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
