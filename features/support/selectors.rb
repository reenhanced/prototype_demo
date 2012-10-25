module Selectors
  def selector_for(scope)
    case scope
      when /the call log details for #(\d+)/i     then "#call_log_#{$1}_details"
      when /the call log listing/i                then "#all-calls"
      when /the family member listing/i           then "#all-family-members"
      when /the new call log contacts/i           then "#call_log_contact_id"
      when /the new call log form/i               then "#new_call_log"
      when /the new call log recorded at fields/i then "#new-call-datetime"
      when /the search error alert/i              then "#ajax-search-error"
      when /the alert box/i                       then ".alert-error"
      when /the new family member form/i          then "#new_family_member"
      when /the edit family member row/i          then "#edit_family_member_#{FamilyMember.last.id}"
      when /the new student form/i                then "#new-student"
      when /the popup modal/i                     then "body.modal-open"
      when /the prospect search button/i          then "#card-search-form input[name=commit]"
      when /the search error alert/i              then "#ajax-search-error"
      when /the student listing/i                 then "#all-students"
      when "the top navigation bar"               then "#top_nav_bar"
      when /the view all button/i                 then "#card-search-form input[name=view_all]"
      when /the student row/i                     then "#student-#{Student.last.id}-row"
      when /the edit student row/i                then "#edit_student_#{Student.last.id}"
      when /^"([#.]+[a-z0-9\-_]*)"$/i             then $1
      else raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
                 "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(Selectors)
