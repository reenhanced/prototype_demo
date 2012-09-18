class CreateFamilyCards < ActiveRecord::Migration
  def self.up
    create_table :family_cards do |t|
      t.string :parent_first_name
      t.string :parent_last_name
      t.string :student_name
      t.string :phone
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :primary_parent_id
      t.timestamps
    end
  end

  def self.down
    drop_table :family_cards
  end
end
