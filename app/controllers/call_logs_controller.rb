class CallLogsController < ApplicationController
  before_filter :find_family_card
  before_filter :find_call, except: [:create]

  respond_to :js

  def create
    qualifier_ids = params[:call_log].try(:delete, :qualifier_ids)
    @call = @family_card.calls.build(params[:call_log])
    @call.qualifier_ids = qualifier_ids if qualifier_ids

    if @call.save
      flash[:notice] = "Successfully added call log."
    else
      flash[:error] = "We were unable to create the call log. Please check the information you entered and try again."
    end
    respond_with @call
  end

  def destroy
    @call.destroy
    redirect_to @family_card, :notice => "Successfully destroyed call log."
  end

  private
  def find_family_card
    @family_card = FamilyCard.find(params[:family_card_id])
  end

  def find_call
    @call = @family_card.calls.find(params[:id])
  end
end
