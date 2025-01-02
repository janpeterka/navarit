class ChangeRecipeIngredientAmountFromFloatToDecimal < ActiveRecord::Migration[8.0]
  def change
    change_column :recipes_have_ingredients, :amount, :decimal, precision: 12, scale: 2
  end
end
