class AddUserRefToOutfits < ActiveRecord::Migration
  def change
    add_reference :outfits, :user, index: true
  end
end
