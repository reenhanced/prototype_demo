class StudentsController < ApplicationController
  before_filter :find_family_card
  before_filter :find_student, except: [:create]
  authorize_resource

  respond_to :js

  def create
    @student = @family_card.students.build(student_params)

    if params[:use_default_parent]
      @student.email    = @family_card.parent_email
      @student.phone    = @family_card.parent_phone
      @student.address1 = @family_card.parent_address1
      @student.address2 = @family_card.parent_address2
      @student.city     = @family_card.parent_city
      @student.state    = @family_card.parent_state
      @student.zip_code = @family_card.parent_zip_code
    end

    if @student.save
      flash[:notice] = "Successfully added student."
    else
      flash[:error] = "We were unable to save the student.  Please check the information you entered and try again."
    end
    respond_with @student
  end

  def destroy
    @student.destroy
    redirect_to @family_card, :notice => "Successfully removed the student."
  end

  private
  def find_family_card
    @family_card = FamilyCard.find(params[:family_card_id])
  end

  def find_student
    @student = @family_card.students.find(params[:id])
  end

  def student_params
    params.require(:student).permit :first_name, :last_name,
                                    :email,      :phone,
                                    :address1,   :address2,
                                    :city,       :state,    :zip_code,
                                    :gender,     :birthday,
                                    :graduation_year
  end
end
