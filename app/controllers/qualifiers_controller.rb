class QualifiersController < ApplicationController
  before_filter :find_family_card
  before_filter :find_qualifier, except: [:create]
  authorize_resource

  respond_to :js

  def create
    @qualifier = @family_card.qualifiers.build(params[:qualifier])

    if @qualifier.save
      flash[:notice] = "Successfully added qualifier."
    else
      flash[:error] = "We were unable to save the qualifier. Please check the information you entered and try again."
    end
    respond_with @qualifier
  end

  def destroy
    @qualifier.destroy
    redirect_to @family_card, :notice => "Successfully destroyed qualifier."
  end

  private
  def find_family_card
    @family_card = FamilyCard.find(params[:family_card_id])
  end

  def find_qualifier
    @qualifier = @family_card.qualifiers.find(params[:id])
  end
end
