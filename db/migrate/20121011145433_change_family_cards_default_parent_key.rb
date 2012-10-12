class ChangeFamilyCardsDefaultParentKey < ActiveRecord::Migration
  def up
    rename_column :family_cards, :primary_parent_id, :default_parent_id
  end

  def down
    rename_column :family_cards, :default_parent_id, :primary_parent_id
  end
end
