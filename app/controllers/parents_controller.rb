class ParentsController < ApplicationController
  before_filter :find_family_card
  before_filter :find_parent, except: [:create]

  respond_to :js

  def create
    @parent = @family_card.parents.build(parent_params)

    if params[:use_default_parent]
      @parent.email    = @family_card.parent_email
      @parent.phone    = @family_card.parent_phone
      @parent.address1 = @family_card.parent_address1
      @parent.address2 = @family_card.parent_address2
      @parent.city     = @family_card.parent_city
      @parent.state    = @family_card.parent_state
      @parent.zip_code = @family_card.parent_zip_code
    end

    if @parent.save
      flash[:notice] = "Successfully added parent."
    else
      flash[:error] = "We were unable to save the parent.  Please check the information you entered and try again."
    end
    respond_with @parent
  end

  def destroy
    @parent.destroy
    redirect_to @family_card, :notice => "Successfully removed the parent."
  end

  private
  def find_family_card
    @family_card = FamilyCard.find(params[:family_card_id])
  end

  def find_parent
    @parent = @family_card.parents.find(params[:id])
  end

  def parent_params
    params.require(:parent).permit :first_name, :last_name,
                                    :email,      :phone,
                                    :address1,   :address2,
                                    :city,       :state,    :zip_code
  end
end
