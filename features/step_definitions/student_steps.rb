Then /^the family card should have (\d+) student[s]?$/ do |student_count|
  @family_card ||= FamilyCard.last
  @family_card.reload
  @family_card.students.should have(student_count).students
end

Then /^I should( not)? see the student's information( with the default parent's contact info)?$/ do |negator, matches_parent|
  @family_card ||= FamilyCard.last
  @family_card.reload
  student         = @family_card.students.last
  student_address = "*#{student.address1}*#{student.address2}*#{student.city}, #{student.state} #{student.zip_code}*"
  family_address  = "*#{@family_card.address1}*#{@family_card.address2}*#{@family_card.city}, #{@family_card.state} #{@family_card.zip_code}*"

  if matches_parent
    steps %{
      Then I should see the following table rows:
        | First Name            | Last Name            | Email                 | Phone                 | Address           |
        | #{student.first_name} | #{student.last_name} | #{@family_card.email} | #{@family_card.phone} | #{family_address} |
    }
  else
    steps %{
      Then I should see the following table rows:
        | First Name            | Last Name            | Email            | Phone            | Address            |
        | #{student.first_name} | #{student.last_name} | #{student.email} | #{student.phone} | #{student_address} |
    }
  end
end
