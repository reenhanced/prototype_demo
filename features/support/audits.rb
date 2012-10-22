require 'cucumber/rails'
module AuditHelpers
  # Maps a name to an audited object. Used by the
  #
  #   Then /^I should see the following audit table for (.+)$/ do |audited_model|
  #
  # step definition in audit_steps.rb
  #
  def audits_for(audit_name)
    action             = audit_name.gsub(/the (created|updated|destroyed) .*/) {|match| $1}
    action             = (action =~ /yed$/) ? action.gsub(/ed$/, '') : action.gsub(/d$/, '')
    use_default_parent = (audit_name =~ /family card's default parent/)
    audit_name         = audit_name.gsub(/the (created |updated |destroyed )?(family card's )?/, '').parameterize('_')

    if use_default_parent
      raise "No @family_card exists, please set it before calling audit_model_for" unless @family_card

      default_parent = @family_card.default_parent

      if action.present?
        conditions = {action: action, auditable_id: default_parent.id, auditable_type: default_parent.class}
      else
        conditions = {auditable_id: default_parent.id, auditable_type: default_parent.class}
      end
    else
      begin
        last_audited_object = audit_name.constantize.last

        # handle special case for student
        audit_name = 'FamilyMember' if audit_name == 'Student' if audit_name =~ /student/i

        if action.present?
          conditions = {action: action_name, auditable_id: last_audited_object.id, auditable_type: audit_name}
        else
          conditions = {auditable_id: last_audited_object.id, auditable_type: audit_name}
        end
      rescue Object => e
        raise "Can't find the last row in the database for: \"#{audit_name}\""
      end
    end

    audits = Audit.with_associated_for(@family_card).where(conditions)
    audits || raise("No audits found for #{@family_card.name} where => action: '#{action}', auditable_id: '#{default_parent.id}', auditable_type: '#{default_parent.class}'")
  end
end

World(AuditHelpers)
