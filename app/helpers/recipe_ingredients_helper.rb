# frozen_string_literal: true

module RecipeIngredientsHelper
  def formatted_amount_with_unit(recipe_ingredient, portion_count)
    amount = recipe_ingredient.amount * portion_count
    ingredient = recipe_ingredient.ingredient

    case amount
    when 1000..Float::INFINITY
      "#{formatted_amount(amount / 1000)} #{ingredient.measurement.thousand_fold}"
    else
      "#{formatted_amount(amount)} #{ingredient.measurement.name}"
    end
  end

  private

  def formatted_amount(amount)
    return nil if amount.nil?
    return 0 if amount.zero?

    digits = if amount.floor.zero?
               0
             else
               Math.log10(amount.floor).to_i + 1
             end

    case digits
    when 0, 1
      amount.round(1)
    else
      amount.round
    end
  end
end
