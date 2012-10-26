class CallLogsController < ApplicationController
  before_filter :find_family_card
  before_filter :find_call, except: [:create]
  authorize_resource

  respond_to :js

  def create
    @call_log               = @family_card.call_logs.build(call_log_params)
    @call_log.qualifier_ids = params[:qualifier_ids] if params[:qualifier_ids]

    respond_to do |format|
      if @call_log.save
        format.html do
          render json: {
            call_row: render_to_string(partial: 'call_logs/call_row',
                                       formats: [:html],
                                       locals: { call_log: @call_log }),
            qualifiers: render_to_string(partial: 'call_logs/qualifiers',
                                       formats: [:html],
                                       locals: { qualifiers: @call_log.qualifiers }),
            },
            status: :ok
        end
      else
        format.html do
          render partial: 'shared/error_messages',
                 locals: { record: @call_log },
                 status: :unprocessable_entity
        end
      end
    end
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
