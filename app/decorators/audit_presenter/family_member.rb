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
end
