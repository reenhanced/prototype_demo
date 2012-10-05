module Selectors
  def selector_for(scope)
    case scope
      when /the new call log form/i               then "#new-call"
      when /the new call log contacts/i           then "#call_log_contact_id"
      when /the call log listing/i                then "#all-calls"
      when /the new call log recorded at fields/i then "#new-call-datetime"
      when /^([#.]+[a-z0-9\-_]*)$/i               then $1
      else raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
                 "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(Selectors)
