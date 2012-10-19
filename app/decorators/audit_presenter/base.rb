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
    if audit.auditable.present?
      audit.auditable.to_s
    else
      audit.revision.to_s
    end
  end

  def visible?
    true
  end

  def changes_table(table_html_options = {})
    return unless visible? and audited_changes.any?

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
          h.content_tag(:td, field_name(field)) +
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
  def audited_changes
    # keep a cached version
    return @audited_changes if @audited_changes.present?

    @audited_changes = {}
    audit.audited_changes.each do |field, change|
      from, to = changeset_for(field, change)
      if from.present? or to.present?
        @audited_changes[field.to_sym] = {from: from, to: to}
      end
    end
    @audited_changes
  end

  def field_name(field)
    (audit.revision || audit.auditable).class.human_attribute_name(field).downcase
  end

  def changeset_for(field, change)
    if respond_to?(:"#{field}_change")
      send("#{field}_change", change)
    else
      if change.is_a?(Array)
        [changed_field_from(field, change[0]), changed_field_to(field, change[1])]
      else
        [nil, changed_field_to(field, change)]
      end
    end
  end

  def changed_field_from(field, value)
    field = field.to_s.gsub(/_id$/, '').strip.to_sym if field.to_s =~ /_id$/
    from  = value
    from  = audit.revision.try(field) if audit.revision.present? and audit.revision.respond_to?(field)
  end

  def changed_field_to(field, value)
    field = field.to_s.gsub(/_id$/, '').strip.to_sym if field.to_s =~ /_id$/
    to    = value
    to    = audit.revision.try(field) if audit.revision.respond_to?(field)
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
