class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string  :address1
      t.string  :address2
      t.date    :birthday
      t.string  :city
      t.string  :email
      t.integer :family_card_id
      t.string  :first_name
      t.integer :graduation_year
      t.string  :gender, :limit => 1
      t.string  :last_name
      t.string  :phone
      t.string  :relationship
      t.string  :state
      t.string  :zip_code
      t.timestamps
    end

    add_index :students, :family_card_id
  end

  def self.down
    remove_index :students, :family_card_id
    drop_table :students
  end
end
