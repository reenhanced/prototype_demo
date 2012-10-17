class AuditPresenter::FamilyCard < AuditPresenter::Base
  def changes(table_html_options = {})
    audited_changes = {}
    audit.audited_changes.each do |field, change|
      from, to = changeset_for(field, change)
      if from.present? or to.present?
        audited_changes[:"#{field}"] = {from: from, to: to}
      end
    end

    return unless audited_changes.any? or audit.action == 'create'

    if audit.action == 'create'
      FamilyMember.audited_columns.collect do |column|
        value = audit.auditable.default_parent.send(column.name.to_sym)
        next unless value.present?
        audited_changes[column.name.to_sym] = {from: nil, to: value}
      end
    end

    thead = h.content_tag :thead do
      h.content_tag :tr do
        h.content_tag(:th, I18n.translate("audit.changes.attribute")) +
        h.content_tag(:th, I18n.translate("audit.changes.from")) +
        h.content_tag(:th, I18n.translate("audit.changes.to"))
      end
    end

    tbody = h.content_tag :tbody do
      audited_changes.collect do |field, change|
        h.content_tag :tr do
          h.content_tag(:td, field) +
          h.content_tag(:td, change[:from]) +
          h.content_tag(:td, change[:to])
        end
      end.join("").html_safe
    end

    table = h.content_tag :table, table_html_options do
      thead + tbody
    end

    h.content_tag(:strong, FamilyCard.human_attribute_name(:default_parent)) + table
  end

end
