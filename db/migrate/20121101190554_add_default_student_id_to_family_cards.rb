class AddDefaultStudentIdToFamilyCards < ActiveRecord::Migration
  def change
    add_column :family_cards, :default_student_id, :integer
  end
end
