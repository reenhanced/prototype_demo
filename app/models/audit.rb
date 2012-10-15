class Audit < Audited::Adapters::ActiveRecord::Audit
  def self.with_associated_for(auditor = nil)
    return [] unless auditor
    where(
      arel_table[:auditable_id].eq(auditor.id).and(
        arel_table[:auditable_type].eq(auditor.class.to_s)
      ).or(
        arel_table[:associated_id].eq(auditor.id).and(
          arel_table[:associated_type].eq(auditor.class.to_s)
        )
      )
    )
  end
end
