# frozen_string_literal: true

class EventShoppingList
  include ActiveModel::Model
  include PrawnHelper

  attr_accessor :event

  def initialize(event)
    @event = Event.includes(daily_plans: { daily_plan_recipes: { recipe: { recipe_ingredients: { ingredient: :measurement } } } }) # rubocop:disable Layout/LineLength
                  .find(event.id)
  end

  def shoppings # rubocop:disable Metrics/AbcSize
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

  def pdf
    document = shrimpy_document(title: "Nákupní seznam na #{@event.name}")

    shoppings.each do |shopping|
      shopping.shrimpy_print(document)
    end

    document
  end
end

class Shopping
  include DateHelper
  include PrawnHelper
  include ::RecipeIngredientsHelper

  attr_accessor :event, :date, :day_recipes

  def name = "nákup (#{formatted_date(@date)} - #{weekday_name(@date)})"

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

  def shrimpy_print(document)
    document.start_new_page unless document.page_number == 1

    document.text name, size: 18, style: :bold

    shrimpy_ingredients_table(document)
  end

  def shrimpy_ingredients_table(document)
    ingredients_with_usage.group_by { |i| i.first.category }.each do |category, ingredients_with_usage|
      document.text category&.name || "ostatní", size: 12, style: :bold
      shrimpy_table(ingredients_table_data(ingredients_with_usage), document:, keep_together: false)
      document.move_down 7
    end
  end

  private

  def ingredients_table_data(ingredients_with_usage)
    data = []
    ingredients_with_usage.each do |ingredient, usage|
      data << [ ingredient.name,
               formatted_amount_and_unit(amount: usage[:amount].to_i, measurement: ingredient.measurement) ]
    end
    data
  end
end

class LastingIngredientShopping < Shopping
  def name = "nákup trvanlivých surovin"

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
