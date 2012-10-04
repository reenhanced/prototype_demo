module Selectors
  def selector_for(scope)
    case scope
      when /the new call log form/i then "#new-call"
      when /^([#.]+[a-z0-9\-_]*)$/i then $1
      else raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
                 "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(Selectors)
