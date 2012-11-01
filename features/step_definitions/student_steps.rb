Given /^the family card has a default student "(.*)"$/ do |student_name|
  @family_card ||= FamilyCard.last
  first_name, last_name = student_name.split(' ')
  @family_card.default_student = create(:student, family_card: @family_card, first_name: first_name, last_name: last_name)
  @family_card.save!
end

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
  parent_address  = "*#{@family_card.parent_address1}*#{@family_card.parent_address2}*#{@family_card.parent_city}, #{@family_card.parent_state} #{@family_card.parent_zip_code}*"

  if matches_parent
    steps %{
      Then I should see the following table rows:
        | First Name            | Last Name            | Email                        | Phone                        | Address           |
        | #{student.first_name} | #{student.last_name} | #{@family_card.parent_email} | #{@family_card.parent_phone} | #{parent_address} |
    }
  else
    steps %{
      Then I should see the following table rows:
        | First Name            | Last Name            | Email            | Phone            | Address            |
        | #{student.first_name} | #{student.last_name} | #{student.email} | #{student.phone} | #{student_address} |
    }
  end
end

Then /^the family card's default student should be "(.*)"$/ do |student_name|
  @family_card ||= FamilyCard.last
  @family_card.reload
  @family_card.default_student.to_s.should == student_name
end
