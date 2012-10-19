class AuditPresenter::FamilyCard < AuditPresenter::Base
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

    if audit.action == 'create'
      FamilyMember.audited_columns.collect do |column|
        column_name = column.name.gsub(/_id$/, '')
        value = audit.auditable.default_parent.send(column_name).to_s
        next unless value.present?
        @audited_changes[column.name] = {from: nil, to: value}
      end
    end
    @audited_changes
  end
end
