class AddUserIdToFamilyCards < ActiveRecord::Migration
  def change
    add_column :family_cards, :user_id, :integer
    add_index :family_cards, :user_id
  end
end
