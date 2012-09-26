Then /^the family card should have (\d+) student[s]?$/ do |student_count|
  @family_card ||= FamilyCard.last
  @family_card.reload
  @family_card.students.should have(student_count).students
end

Then /^I should( not)? see the student's information$/ do |negator|
  @family_card ||= FamilyCard.last
  @family_card.reload
  student = @family_card.students.last

  step %{
    I should#{negator} see the following table rows:
      | First Name | Last Name | Email | Phone | Address |
      | #{student.first_name} | #{student.last_name} | #{student.email} | #{student.phone} | #{student.address1} |
  }
end
