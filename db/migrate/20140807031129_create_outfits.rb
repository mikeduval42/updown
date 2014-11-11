class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :type_of_outfit
      t.string :occasion
      t.string :brand_name
      t.string :price
      t.string :accessories
      t.string :sender_comment

      t.timestamps
    end
  end
end
