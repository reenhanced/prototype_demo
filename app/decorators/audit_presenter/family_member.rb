class AuditPresenter::FamilyMember < AuditPresenter::Base
  def visible?
    return false if audit.auditable == audit.associated.default_parent and audit.action == 'create'
  end
end
