class AuditPresenter::Base
  def initialize(audit, decorator)
    @audit = audit
    proxy_view_helpers(decorator)
  end

  def action
    "#{I18n.translate("audit.actions.#{audit.action}")} #{humanized_class_name}"
  end

  def author
    (audit.user.try(:name) || audit.username)
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
          h.content_tag(:td, field) +
          h.content_tag(:td, change[:from]) +
          h.content_tag(:td, change[:to])
        end
      end.join("").html_safe
    end

    h.content_tag :table, table_html_options do
      thead + tbody
    end
  end

  def visible?
    true
  end

  protected
  def changeset_for(field, change)
    if respond_to?(:"#{field}_change")
      send("#{field}_change", change)
    else
      if change.is_a?(Array)
        [change[0], change[1]]
      else
        [nil, change]
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
    audit.auditable_type.constantize.model_name.human
  end

  def audit
    @audit
  end

  def change_type(change)
    change[1].class
  end
end
