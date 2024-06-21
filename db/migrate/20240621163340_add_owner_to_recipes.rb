class AddOwnerToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :owner, polymorphic: true, null: false, after: :created_by

    Recipe.all.each do |recipe|
      recipe.update(owner: recipe.author)
    end
  end
end
