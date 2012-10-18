class AuditPresenter::FamilyMember < AuditPresenter::Base
  def visible?
    case audit.action
    when 'create'
      return false if audit.auditable == audit.associated.default_parent
    when 'update'
      return false if audit.audited_changes.keys == ['family_card_id']
    end
    return true
  end

  private
  def humanized_class_name
    if audit.auditable.present?
      audit.auditable.type.titleize
    else
      audit.auditable_type.titleize
    end
  end

end
