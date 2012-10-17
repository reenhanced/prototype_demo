class FamilyCards::AuditsController < ApplicationController
  load_and_authorize_resource :family_card
  load_and_authorize_resource :audited, :through => :family_card

  def show
    @family_card = FamilyCard.find(params[:id])
    @audits = AuditDecorator.decorate(Audit.with_associated_for(@family_card))
  end
end
