class Student < FamilyMember
  BIRTHDAY_YEAR_OFFSET   = 20
  GRADUATION_YEAR_OFFSET = 20

  attr_accessible :gender, :birthday, :graduation_year, :relationship

  def default?
    family_card.present? and self == family_card.default_student
  end
end
