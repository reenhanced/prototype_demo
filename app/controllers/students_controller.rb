class StudentsController < ApplicationController
  before_filter :find_family_card
  before_filter :find_student, except: [:create]
  authorize_resource

  respond_to :js

  def create
    @student = @family_card.students.build(student_params)

    if @student.save
      flash[:notice] = "Successfully added student."
    else
      flash[:error] = "We were unable to save the student.  Please check the information you entered and try again."
    end
    respond_with @student
  end

  def update
    if @student.update_attributes(student_params)
      flash[:notice] = "Successfully updated student."
    else
      flash[:error] = "We were unable to update the student.  Please check the information you entered and try again."
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
    params.require(:student).permit :first_name,     :last_name,
                                    :email,          :phone,
                                    :address1,       :address2,
                                    :city,           :state,
                                    :zip_code,       :gender,
                                    :birthday,       :graduation_year,
                                    :relationship,   :'birthday(1i)',
                                    :'birthday(2i)', :'birthday(3i)'
  end
end
