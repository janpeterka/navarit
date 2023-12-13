# frozen_string_literal: true

class EventCookbook
  include ActiveModel::Model
  include DateHelper
  include ::RecipeIngredientsHelper

  attr_reader :event

  def initialize(event)
    @event = Event.includes(daily_plans: { daily_plan_recipes: :recipe }).find(event.id)
  end

  def pdf # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    document = Prawn::Document.new(margin: 30, page_size: 'A4', page_layout: :portrait)

    document.font_families.update('DejaVu' => {
                                    normal: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans.ttf",
                                    bold: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans-Bold.ttf",
                                    italic: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans-Oblique.ttf",
                                    bold_italic: "#{Rails.root}/fonts/dejavu/ttf/DejaVuSans-BoldOblique.ttf"
                                  })

    document.font 'DejaVu'

    @event.daily_plans.each do |day|
      document.start_new_page unless document.page_number == 1

      document.text "#{weekday_name(day.date)} #{formatted_date(day.date)}", size: 18, style: :bold
      document.move_down 15

      day.daily_plan_recipes.each do |daily_recipe|
        recipe = daily_recipe.recipe
        document.text recipe.name, size: 16, style: :bold
        document.text "(pro #{daily_recipe.portion_count.to_i} lidí)", size: 10,
                                                                       style: :italic
        document.move_down 7
        document.markup recipe.description&.html_safe
        document.move_down 10
        document.text 'suroviny:', style: :bold
        ingredient_data = []
        daily_recipe.recipe.recipe_ingredients.each do |recipe_ingredient|
          ingredient = recipe_ingredient.ingredient
          ingredient_data << [ingredient.name,
                              formatted_amount_with_unit(recipe_ingredient,
                                                         daily_recipe.portion_count)]
        end
        document.table(ingredient_data, cell_style: { borders: [], padding: 2 },
                                        column_widths: [document.bounds.width / 2, document.bounds.width / 2])
        document.move_down 10
      end
      document.move_down 20
    end

    document.number_pages '<page> / <total>', {
      start_count_at: 1,
      page_filter: :all,
      at: [document.bounds.right - 30, 0],
      align: :center,
      size: 10
    }
    document
  end
end
