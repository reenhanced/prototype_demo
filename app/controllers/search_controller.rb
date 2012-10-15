class SearchController < ApplicationController
  skip_authorization_check :only => :new

  def new
  end

  def create
    @family_cards = if params[:family_member].values.all?(&:blank?) and current_user.is?(:admin)
                      FamilyCard.all
                    else
                      FamilyCard.find_all_from_search(params[:family_member])
                    end

    authorize! :show, @family_cards

    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
