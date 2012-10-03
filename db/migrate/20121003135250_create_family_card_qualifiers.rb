class CreateFamilyCardQualifiers < ActiveRecord::Migration
  def up
    create_table :family_card_qualifiers do |t|
      t.integer :family_card_id
      t.integer :qualifier_id
      t.timestamps
    end
    add_index :family_card_qualifiers, :family_card_id
    add_index :family_card_qualifiers, :qualifier_id
  end

  def down
    remove_index :family_card_qualifiers, :family_card_id
    remove_index :family_card_qualifiers, :qualifier_id
    drop_table :family_card_qualifiers
  end
end
