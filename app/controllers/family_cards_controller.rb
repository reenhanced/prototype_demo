class FamilyCardsController < ApplicationController
  load_and_authorize_resource :except => :create

  def search
    @family_cards = FamilyCard.find_all_from_search(params[:family_member])
    flash[:error] = render_to_string(:partial => "no_results_message").html_safe if params[:family_member].present? and @family_cards.empty?
  end

  def show
    @family_members = @family_card.family_members
    @student        = @family_card.students.build
    @family_member  = @family_card.family_members.build
    @call_log       = @family_card.call_logs.build
  end

  def new
  end

  def create
    @family_card      = FamilyCard.new(family_card_params)
    @family_card.user = current_user

    authorize! :create, @family_card

    if @family_card.save
      redirect_to @family_card, :notice => "Successfully created family card."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @family_card.update_attributes(family_card_params)
      redirect_to @family_card, :notice  => "Successfully updated family card."
    else
      render :action => 'edit'
    end
  end

  private
  def family_card_params
    params.require(:family_card).permit(:parent_first_name, :parent_last_name,
                                        :parent_phone,      :parent_email,
                                        :parent_address1,   :parent_address2,
                                        :parent_city,       :parent_state,     :parent_zip_code)
  end
end
