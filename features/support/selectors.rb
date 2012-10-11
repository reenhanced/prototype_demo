module Selectors
  def selector_for(scope)
    case scope
      when /the popup modal/i                     then "body.modal-open"
      when /the new student form/i                then "#new-student"
      when /the student listing/i                 then "#all-students"
      when /the new parent form/i                then "#new-parent"
      when /the parent listing/i                 then "#all-parents"
      when /the new call log form/i               then "#new_call_log"
      when /the new call log contacts/i           then "#call_log_contact_id"
      when /the call log listing/i                then "#all-calls"
      when /the call log details for #(\d+)/i     then "#call_log_#{$1}_details"
      when /the new call log recorded at fields/i then "#new-call-datetime"
      when /^"([#.]+[a-z0-9\-_]*)"$/i               then $1
      else raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
                 "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(Selectors)
