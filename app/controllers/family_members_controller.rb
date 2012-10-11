class FamilyMembersController < ApplicationController
  before_filter :find_family_card
  before_filter :find_family_member, except: [:create]
  before_filter :use_default_parent_contact, only: [:create]

  respond_to :js

  def create
    @family_member = @family_card.family_members.build(family_member_params)

    if @family_member.save
      flash[:notice] = "Successfully added family member."
    else
      flash[:error] = "We were unable to save the family member.  Please check the information you entered and try again."
    end
    respond_with @family_member
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
    found_object = @family_card.send("#{self.table_name}.find", params[:id])
    self.instance_variable_set("@#{self.table_name[0..-2]}", found_object)
  end

  def use_default_parent_contact
    if params[:use_default_family_member]
      instance_object = self.instance_variable_get("@#{self.table_name[0..-2]}")
      instance_object.email    = @family_card.parent_email
      instance_object.phone    = @family_card.parent_phone
      instance_object.address1 = @family_card.parent_address1
      instance_object.address2 = @family_card.parent_address2
      instance_object.city     = @family_card.parent_city
      instance_object.state    = @family_card.parent_state
      instance_object.zip_code = @family_card.parent_zip_code
    end
  end

  def family_member_params
    params.require(:family_member).permit :first_name, :last_name,
                                    :email,      :phone,
                                    :address1,   :address2,
                                    :city,       :state,    :zip_code
  end
end
