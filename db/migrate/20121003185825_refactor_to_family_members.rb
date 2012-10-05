class RefactorToFamilyMembers < ActiveRecord::Migration
  def change
    create_table :family_members do |t|
      t.string  :type
      t.integer :family_card_id
      t.string  :first_name
      t.string  :last_name
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :state
      t.string  :zip_code

      t.string  :gender, :limit => 1
      t.string  :phone
      t.string  :email
      t.date    :birthday
      t.integer :graduation_year
      t.string  :relationship
      t.timestamps
    end

    add_index :family_members, :family_card_id

    drop_table :students
    drop_table :parents
    remove_column :family_cards, :parent_first_name, :parent_last_name, :student_name, :phone, :email,
                                 :address1, :address2, :city, :state, :zip_code
  end
end
