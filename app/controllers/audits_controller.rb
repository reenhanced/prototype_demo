class AuditsController < ApplicationController
  load_and_authorize_resource :family_card
  authorize_resource :audited, :through => :family_card

  def index
    @audits = Audit.with_associated_for(@family_card).decorate.select do |audit_presenter|
      audit_presenter.visible?
    end
  end
end
