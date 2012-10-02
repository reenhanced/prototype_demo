class CreateQualifiers < ActiveRecord::Migration
  def self.up
    create_table :qualifiers do |t|
      t.string :name
      t.string :category
      t.integer :position, :default => 0
      t.integer :family_card_id
      t.timestamps
    end
  end

  def self.down
    drop_table :qualifiers
  end
end
