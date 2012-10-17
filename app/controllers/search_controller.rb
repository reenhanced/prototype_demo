class SearchController < ApplicationController
  def new
    authorize! :read, FamilyCard
  end

  def create
    @family_cards = if params[:view_all] and can?(:browse, :all_family_cards)
                      FamilyCard.all
                    else
                      FamilyCard.find_all_from_search(params[:family_member])
                    end

    authorize! :read, FamilyCard

    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
