class AuditPresenter::Base
  def initialize(audit)
    @audit = audit
  end

  def action
    "#{I18n.translate("audit.actions.#{audit.action}")} #{humanized_class_name}"
  end

  def changes
    thead = h.content_tag :thead do
      h.content_tag :tr do
        h.content_tag(:th, I18n.translate("audit.action")) +
        h.content_tag(:th, I18n.translate("audit.changes")) +
        h.content_tag(:th, I18n.translate("audit.author"))
      end
    end

    changes_thead = h.content_tag :thead do
      h.content_tag(:th, I18n.translate("audit.changes.attribute")) +
      h.content_tag(:th, I18n.translate("audit.changes.from")) +
      h.content_tag(:th, I18n.translate("audit.changes.to"))
    end

    changes_tbody = h.content_tag :tbody do
      audit.audited_changes.each do |field, change|
        from, to = changeset_for(field)
        if from.present? or to.present?
          h.content_tag :tr do
            h.content_tag(:td, from) +
            h.content_tag(:td, to)
          end
        end
      end
    end

    changes_table = h.content_tag :table, :class => 'table' do
      changes_thead + changes_tbody
    end

    tbody = h.content_tag :tbody do
      h.content_tag :tr do
        h.content_tag(:td, action) +
        changes_tbody +
        h.content_tag(:td, audit.user.name + content_tag(:br) + audit.created_at)
      end
    end

    h.content_tag :table, :class => 'table' do
      thead + tbody
    end
  end

  protected
  def changeset_for(field, change)
    if respond_to(:"#{field}_change")
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
