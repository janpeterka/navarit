# frozen_string_literal: true

module RecipeIngredientsHelper
  # portion count is normally counted from recipe, but in case user is viewing recipe with different portion count,
  #  it can be passed as optional parameter
  def formatted_amount_with_unit(recipe_ingredient, portion_count = recipe_ingredient.recipe.portion_count)
    return "0 #{recipe_ingredient.ingredient.measurement&.name}" if recipe_ingredient.amount.nil?

    amount = recipe_ingredient.amount * portion_count
    measurement = recipe_ingredient.ingredient.measurement

    return "#{formatted_amount(amount)} #{measurement&.name}" if measurement&.thousand_fold.blank?

    case amount
    when 1000..Float::INFINITY
      "#{formatted_amount(amount / 1000)} #{formatted_unit(amount, measurement)}"
    else
      "#{formatted_amount(amount)} #{formatted_unit(amount, measurement)}"
    end
  end

  def formatted_unit(amount, measurement)
    return measurement.name if measurement.thousand_fold.blank?

    case amount
    when 1000..Float::INFINITY
      measurement.thousand_fold
    else
      measurement.name
    end
  end

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
