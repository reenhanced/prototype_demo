require 'cucumber/rails'
module AuditHelpers
  # Maps a name to an audited object. Used by the
  #
  #   Then /^I should see the following audit table for (.+)$/ do |audited_model|
  #
  # step definition in audit_steps.rb
  #
  def audits_for(audit_name)
    action         = audit_name.gsub(/the (created|updated|destroyed) .*/) {|match| $1}
    action         = (action =~ /yed$/) ? action.gsub(/ed$/, '') : action.gsub(/d$/, '')

    case audit_name

    when /the (created |updated |destroyed )?family card's default parent/
      raise "No @family_card exists, please set it before calling audit_model_for" unless @family_card

      audit_name     = audit_name.gsub(/the (created |updated |destroyed )?family card's /, '').parameterize('_')
      default_parent = @family_card.default_parent

      if action.present?
        audits = Audit.with_associated_for(@family_card).where(action: action, auditable_id: default_parent.id, auditable_type: default_parent.class)
      else
        audits = Audit.with_associated_for(@family_card).where(auditable_id: default_parent.id, auditable_type: default_parent.class)
      end

      audits || raise("No audits found for #{@family_card.name} where => action: '#{action}', auditable_id: '#{default_parent.id}', auditable_type: '#{default_parent.class}'")

    else
      begin
        audit_name = audit_name.gsub(/the (created |updated |destroyed )?/, '').parameterize('_').classify
        last_audited_object = audit_name.constantize.last

        # handle special case for student
        audit_name = 'FamilyMember' if audit_name == 'Student' if audit_name =~ /student/i

        if action.present?
          audits = Audit.with_associated_for(@family_card).where(action: action_name, auditable_id: last_audited_object.id, auditable_type: audit_name)
        else
          audits = Audit.with_associated_for(@family_card).where(auditable_id: last_audited_object.id, auditable_type: audit_name)
        end
      rescue Object => e
        raise "Can't find the last row in the database for: \"#{audit_name}\""
      end
    end
  end
end

World(AuditHelpers)
