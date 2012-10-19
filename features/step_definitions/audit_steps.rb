Given /^(?:I have|there is) an?(.*)? (.*)? audit(.*)$/ do |action, auditable_type, audit_trait|
  @family_card = create(:family_card)

  audit_trait = audit_trait.parameterize('_').to_sym
  auditable_type = auditable_type.parameterize('_').to_sym

  if action.present?
    action = (action =~ /yed$/) ? action.gsub(/ed$/, '') : action.gsub(/d$/, '')
    create(:audit, audit_trait, action: action.strip, auditable: create(auditable_type, family_card: @family_card), associated: @family_card, user: nil)
  else
    create(:audit, audit_trait, associated: @family_card, user: nil)
  end
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
