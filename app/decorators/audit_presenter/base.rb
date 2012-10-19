class AuditPresenter::Base
  def initialize(audit, decorator)
    @audit = audit
    proxy_view_helpers(decorator)
  end

  def action
    "#{I18n.translate("audit.actions.#{audit.action}")} #{humanized_class_name}"
  end

  def author
    (audit.user.try(:username) || I18n.translate("audit.system_username"))
  end

  def name
    if audit.action == 'create'
      audit.auditable.to_s
    else
      audit.revision.to_s
    end
  end

  def visible?
    true
  end

  def changes(table_html_options = {})
    audited_changes = {}
    audit.audited_changes.each do |field, change|
      from, to = changeset_for(field, change)
      if from.present? or to.present?
        audited_changes[:"#{field}"] = {from: from, to: to}
      end
    end

    return unless audited_changes.any?

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
          h.content_tag(:td, (audit.revision || audit.auditable).class.human_attribute_name(field).downcase) +
          h.content_tag(:td, change[:from]) +
          h.content_tag(:td, change[:to])
        end
      end.join("").html_safe
    end

    h.content_tag :table, table_html_options do
      thead + tbody
    end
  end

  protected
  def changeset_for(field, change)
    if respond_to?(:"#{field}_change")
      send("#{field}_change", change)
    else
      field = field.to_s.gsub(/_id$/, '').strip if field.to_s =~ /_id$/
      if change.is_a?(Array)
        from, to = change
        from     = audit.auditable.try(field.to_sym) if audit.auditable.present? and audit.auditable.respond_to?(field.to_sym)
        to       = audit.revision.try(field.to_sym) if audit.revision.respond_to?(field.to_sym)
        [from.to_s, to.to_s]
      else
        to = change
        to = audit.auditable.try(field.to_sym) if audit.auditable.respond_to?(field.to_sym)
        [nil, to]
      end
    end
  end

  private
  def proxy_view_helpers(decorator)
    self.class.send(:define_method, :h) do
      decorator.helpers
    end
  end

  def humanized_class_name
    audit.auditable_type.titleize
  end

  def audit
    @audit
  end

  def change_type(change)
    change[1].class
  end
end
