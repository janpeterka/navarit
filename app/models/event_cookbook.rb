# frozen_string_literal: true

class EventCookbook
  include ActiveModel::Model
  include DateHelper
  include PrawnHelper
  include ::RecipeIngredientsHelper

  attr_reader :event

  def initialize(event)
    @event = Event.includes(daily_plans: { daily_plan_recipes: { recipe: { recipe_ingredients: { ingredient: :measurement } } } }) # rubocop:disable Layout/LineLength
                  .find(event.id)
  end

  def pdf # rubocop:disable Metrics/AbcSize
    document = shrimpy_document(title: "Kuchařka na #{event.name}")

    @event.daily_plans.each_with_index do |day, ix|
      document.start_new_page

      document.text "#{weekday_name(day.date)} #{formatted_date(day.date)}", size: 18, style: :bold, align: :center
      document.move_down 15

      day.daily_plan_recipes.each do |daily_recipe|
        next if daily_recipe.shopping?

        recipe = daily_recipe.recipe
        document.text recipe.name, size: 16, style: :bold
        document.text "(pro #{daily_recipe.portion_count.to_i} lidí)", size: 10, style: :italic
        document.move_down 7
        document.markup recipe.procedure.to_s
        document.move_down 10

        recipe.shrimpy_ingredients_table(document, daily_recipe:) if recipe.recipe_ingredients.any?
      end
      document.move_down 20

      if day.tasks.any?
        document.text "Úkoly na dnešní den", style: :bold
        document.move_down 15

        day.tasks.each do |task|
          document.text task.name, size: 12
          document.text "(na #{task.recipe.name})", size: 10 if task.is_a?(RecipeTask)
        end
      end
    end

    document.number_pages "<page> / <total>", {
      start_count_at: 1,
      page_filter: :all,
      at: [ document.bounds.right - 30, 0 ],
      align: :center,
      size: 10
    }
    document
  end
end
