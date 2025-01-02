class AddReactionsCountToRecipe < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :reactions_count, :integer, default: 0, null: false

    up_only do
      Recipe.all.each { Recipe.reset_counters(_1.id, :reactions) }
    end
  end
end
