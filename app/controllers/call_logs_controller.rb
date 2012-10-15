class CallLogsController < ApplicationController
  before_filter :find_family_card
  before_filter :find_call, except: [:create]
  authorize_resource

  respond_to :js

  def create
    @call_log               = @family_card.call_logs.build(call_log_params)
    @call_log.qualifier_ids = params[:qualifier_ids] if params[:qualifier_ids]

    if @call_log.save
      flash[:notice] = "Successfully added call log."
    else
      flash[:error] = "We were unable to create the call log. Please check the information you entered and try again."
    end
    respond_with @call_log
  end

  def destroy
    @call_log.destroy
    redirect_to @family_card, :notice => "Successfully destroyed call log."
  end

  private
  def find_family_card
    @family_card = FamilyCard.find(params[:family_card_id])
  end

  def find_call
    @call_log = @family_card.call_logs.find(params[:id])
  end

  def call_log_params
    params.require(:call_log).permit(:message, :contact_id, :contact_type, :'recorded_at(1i)', :'recorded_at(2i)', :'recorded_at(3i)', :'recorded_at(4i)', :'recorded_at(5i)')
  end
end
