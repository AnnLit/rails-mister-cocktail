class AddPhotoToCocktail < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :photo_link, :string
  end
end
