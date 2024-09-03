class ConvertDescriptionToProcedure < ActiveRecord::Migration[7.1]
  def up
    Recipe.find_each do |recipe|
      if recipe.name.blank?
        recipe.name = "!Nevyplněno"
      end

      recipe.update!(procedure: recipe.description)
    end
  end

  def down; end
end
