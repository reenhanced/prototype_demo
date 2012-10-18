Given /^all possible audits exist(?: for a family card)$/ do
  # Creates
  steps %{
    Given the time is "21 Feb 2013 01:00PM"
  }
  @family_card ||= create(:family_card, parent_first_name: "Gordon", parent_last_name: "Ramsy")
  student = create(:student, family_card: @family_card, first_name: "Ramsy", last_name: "Cornerstone")
  parent = create(:parent, family_card: @family_card, first_name: "Amadeus", last_name: "Cornerstone")
  qualifier = create(:qualifier, name: "Can eat own bugers", category: "negative")
  call_log = create(:call_log, family_card: @family_card, contact_id: parent.id, contact_type: parent.class)
  call_log.qualifier_ids = [qualifier.id]
  call_log.save!

  # Updates
  steps %{
    Given the time is "22 Mar 2013 02:00PM"
  }
  @family_card.update_attributes!(parent_first_name: "Carson", parent_last_name: "Daily")
  student.update_attributes!(first_name: "Dawson", last_name: "Lawson")
  parent.update_attributes!(first_name: "Larry", last_name: "Lawson")
  qualifier.update_attributes!(name: "Can eat whole watermelon", category: "positive")
  call_log.update_attributes!(contact_id: student.id, contact_type: student.class)
  call_log.qualifier_ids = []
  call_log.save!

  # Destroys
  call_log.destroy
  qualifier.destroy
  parent.destroy
  student.destroy
end

Then /^I should see the audit changes for (.+)$/ do |audit_type, attributes_changed_from|
  # just ensure we have this set in case the audit lookup needs it
  @family_card       ||= FamilyCard.last
  audits = audits_for(audit_type)
  changed_attributes   = {}

  attributes_changed_from.rows_hash.each do |name, value|
    latest_audit = audits.first

    if !latest_audit.audited_changes.keys.include?(name)
      puts "Audit: #{latest_audit.inspect}"
      raise "The latest audit for #{audit_type} does not contain changes for '#{name}'"
    end

    changed_to = latest_audit.audited_changes[name].try(:[], 1) || latest_audit.audited_changes[name]
    if changed_to != value
      raise "The value for #{audit_type} #{name} changed to '#{changed_to}', but expected '#{value}'"
    end

    if name =~ /_id$/
      model_name = name.gsub(/_id/, '')
      attribute_name = model_name.gsub(/_/, ' ')
      changed_attributes[attribute_name] = latest_audit.audited_changes[name]
    else
      changed_attributes[name.gsub(/_/, ' ')] = latest_audit.audited_changes[name]
    end
  end

  changes = ""
  changed_attributes.each do |attribute, changes|
    changed_from = changes.try(:[], 0) || ''
    changed_to   = changes.try(:[], 1) || changes
    changes << "| #{attribute} | #{changed_from} | #{changed_to} |"
  end

  steps %{
    Then I should see the following table rows:
      | Changed | From | To |
      #{ changes }
  }
end
