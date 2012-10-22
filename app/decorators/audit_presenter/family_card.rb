class AuditPresenter::FamilyCard < AuditPresenter::Base
  def audited_changes
    # keep a cached version
    if @audited_changes.nil?
      @audited_changes = super

      if audit.action == 'create'
        FamilyMember.audited_columns.collect do |column|
          column_name = column.name.gsub(/_id$/, '')
          value = audit.auditable.default_parent.send(column_name).to_s
          next unless value.present?
          @audited_changes[column.name] = {from: nil, to: value}
        end
      end
    end
    @audited_changes
  end
end
