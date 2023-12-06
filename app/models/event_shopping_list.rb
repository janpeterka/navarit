# frozen_string_literal: true

class EventShoppingList
  include ActiveModel::Model

  attr_accessor :event

  def initialize(event)
    @event = event
  end

  def shoppings
    shoppings = []

    lasting_ingredients_shopping = LastingIngredientShopping.new(@event.date_from - 1.day, @event)
    shoppings << lasting_ingredients_shopping

    # initial shopping
    shopping = Shopping.new(@event.date_from - 1.day, @event)

    @event.daily_plans.includes(:daily_plan_recipes).each do |daily_plan|
      daily_plan.daily_plan_recipes.each do |daily_plan_recipe|
        if daily_plan_recipe.shopping?
          # finish previous shopping
          shoppings << shopping
          shopping = Shopping.new(daily_plan.date, @event)
        else
          shopping.day_recipes << daily_plan_recipe
        end
      end
    end
    shoppings << shopping

    shoppings
  end
end

class Shopping
  include DateHelper

  attr_accessor :event, :date, :day_recipes

  def name = "nákup (#{formatted_date(@date)} - #{weekday_name(@date)}"

  def initialize(date, event)
    @date = date
    @event = event
    @day_recipes = []
  end

  def ingredients_with_usage(with_lasting: false)
    ingredients_with_usage = {}

    day_recipes.each do |day_recipe|
      day_recipe.ingredients_with_amounts.each do |ingredient, amount|
        next if with_lasting && ingredient.lasting?

        ingredients_with_usage[ingredient] ||= { amount: 0, recipes: {} }
        ingredients_with_usage[ingredient][:amount] += amount
        ingredients_with_usage[ingredient][:recipes][day_recipe.id] = { day_recipe:, amount: }
      end
    end

    ingredients_with_usage
  end
end

class LastingIngredientShopping < Shopping
  def name = 'nákup trvanlivých surovin'

  def ingredients_with_usage
    ingredients_with_usage = {}

    event.daily_plan_recipes.each do |daily_plan_recipe|
      daily_plan_recipe.ingredients_with_amounts.each do |ingredient, amount|
        next unless ingredient.lasting?

        ingredients_with_usage[ingredient] ||= { amount: 0, recipes: {} }
        ingredients_with_usage[ingredient][:amount] += amount
        ingredients_with_usage[ingredient][:recipes][daily_plan_recipe.id] =
          { day_recipe: daily_plan_recipe, amount: }
      end
    end

    ingredients_with_usage
  end
end
