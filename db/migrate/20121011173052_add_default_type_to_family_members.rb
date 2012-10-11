class AddDefaultTypeToFamilyMembers < ActiveRecord::Migration
  def up
    change_column :family_members, :type, :string, :default => 'FamilyMember'
  end

  def down
    change_column :family_members, :type, :string
  end
end
