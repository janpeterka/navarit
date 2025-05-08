class AddCoverPhotoToRecipe < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :cover_photo_id, :integer
  end
end
