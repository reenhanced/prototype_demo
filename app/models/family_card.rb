class FamilyCard < ActiveRecord::Base
  attr_accessible :parent_first_name, :parent_last_name, :student_name, :phone, :email, :address1, :address2, :city, :state, :zipcode, :primary_parent_id
end
