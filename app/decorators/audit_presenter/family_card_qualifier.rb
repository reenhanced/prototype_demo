class AuditPresenter::FamilyCardQualifier < AuditPresenter::Base
  def action
    "#{I18n.translate("audit.family_card_qualifier.#{audit.action}", :default => :"audit.actions.#{audit.action}")} #{humanized_class_name}"
  end
end
