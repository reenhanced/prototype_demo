class Student < FamilyMember
  BIRTHDAY_YEAR_OFFSET   = 20
  GRADUATION_YEAR_OFFSET = 20

  attr_accessible :first_name, :last_name, :relationship, :gender, :birthday, :graduation_year, :email, :phone, :address1, :address2, :city, :state, :zip_code

end
