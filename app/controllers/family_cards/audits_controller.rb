class FamilyCards::AuditsController < ApplicationController
  def show
    @family_card = FamilyCard.find(params[:id])
    @audits      = @family_card.audits
  end
end
