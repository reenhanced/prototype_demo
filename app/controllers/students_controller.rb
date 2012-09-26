class StudentsController < ApplicationController
  before_filter :find_family_card
  before_filter :find_student, except: [:create]

  respond_to :js

  def create
    @student = @family_card.students.build(params[:student])

    if @student.save
      redirect_to @family_card, :notice => "Successfully added student."
    else
      respond_with @student
    end
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
end
