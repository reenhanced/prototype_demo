module FetchHelpers
  def fetch(model, conditions)
    record = model.to_s.classify.constantize.where(conditions).first
    raise ActiveRecord::RecordNotFound unless record.present?

    record
  end

  def fetch_or_create(model, conditions)
    begin
      fetch(model, conditions)
    rescue ActiveRecord::RecordNotFound
      create(model, conditions)
    end
  end
end

World(FetchHelpers)
