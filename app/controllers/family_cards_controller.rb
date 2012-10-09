class FamilyCardsController < ApplicationController
  before_filter :find_family_card, :except => [:index, :new, :create, :search]

  def search
    @family_cards = FamilyCard.find_all_from_search(params[:family_member])
    flash[:error] = render_to_string(:partial => "no_results_message").html_safe if params[:family_member].present? and @family_cards.empty?
  end

  def show
    @family_members = @family_card.family_members
    @student        = @family_card.students.build
    @call           = @family_card.calls.build
  end

  def new
    @family_card = FamilyCard.new
  end

  def create
    @family_card      = FamilyCard.new(family_card_params)
    @family_card.user = current_user

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
  def find_family_card
    @family_card = FamilyCard.find(params[:id])
  end

  def family_card_params
    params.require(:family_card).permit(:parent_first_name, :parent_last_name,
                                        :parent_phone,      :parent_email,
                                        :parent_address1,   :parent_address2,
                                        :parent_city,       :parent_state,     :parent_zip_code)
  end
end
