class AuditDecorator < Draper::Base
  decorates :audit

  def action
    presenter.action
  end

  def changes(options ={})
    presenter.changes_table options
  end

  def author
    presenter.author
  end

  def name
    presenter.name
  end

  def visible?
    presenter.visible?
  end

  private
  def presenter
    begin
      @presenter ||= "AuditPresenter::#{audit.auditable_type}".constantize.new(audit, self)
    rescue NameError => e
      @presenter = AuditPresenter::Base.new(audit, self)
    end
  end
end
