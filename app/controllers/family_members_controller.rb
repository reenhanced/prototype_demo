class FamilyMembersController < ApplicationController
  before_filter :find_family_card
  before_filter :find_family_member, except: [:create]

  authorize_resource

  respond_to :js

  def create
    @family_member = @family_card.family_members.build(family_member_params)

    if params[:use_default_family_member]
      @family_member.email    = @family_card.parent_email
      @family_member.phone    = @family_card.parent_phone
      @family_member.address1 = @family_card.parent_address1
      @family_member.address2 = @family_card.parent_address2
      @family_member.city     = @family_card.parent_city
      @family_member.state    = @family_card.parent_state
      @family_member.zip_code = @family_card.parent_zip_code
    end

    if @family_member.save
      flash[:notice] = "Successfully added family member."
    else
      flash[:error] = "We were unable to save the family member.  Please check the information you entered and try again."
    end
    respond_with @family_member
  end

  def update
    if @family_member.update_attributes(family_member_params)
      flash[:notice] = "Successfully updated family member."
    else
      flash[:error] = "We were unable to update the family member.  Please check the information you entered and try again."
    end
  end

  def destroy
    @family_member.destroy
    redirect_to @family_card, :notice => "Successfully removed the family member."
  end

  private
  def find_family_card
    @family_card = FamilyCard.find(params[:family_card_id])
  end

  def find_family_member
    @family_member = @family_card.family_members.find(params[:id])
  end

  def family_member_params
    params.require(:family_member).permit :first_name, :last_name,
                                          :email,      :phone,
                                          :address1,   :address2,
                                          :city,       :state,
                                          :zip_code,   :relationship
  end
end
