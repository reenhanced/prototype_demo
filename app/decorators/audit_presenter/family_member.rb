class AuditPresenter::FamilyMember < AuditPresenter::Base
  def visible?
    case audit.action
    when 'create'
      return false if audit.revision == audit.associated.default_parent
    when 'update'
      return false if audit.audited_changes.keys == ['family_card_id']
    end
    return audit.audited_changes.any?
  end

  private
  def humanized_class_name
    if audit.auditable.try(:type).present?
      audit.auditable.type.titleize
    else
      audit.auditable_type.titleize
    end
  end

end
