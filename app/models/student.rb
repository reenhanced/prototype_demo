class Student < FamilyMember
  BIRTHDAY_YEAR_OFFSET   = 20
  GRADUATION_YEAR_OFFSET = 20

  attr_accessible :gender, :birthday, :graduation_year

end
