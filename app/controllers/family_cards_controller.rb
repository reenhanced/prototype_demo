class FamilyCardsController < ApplicationController
  def index
    @family_cards = FamilyCard.all
  end

  def show
    @family_card = FamilyCard.find(params[:id])
  end

  def new
    @family_card = FamilyCard.new
  end

  def create
    @family_card = FamilyCard.new(params[:family_card])
    if @family_card.save
      redirect_to @family_card, :notice => "Successfully created family card."
    else
      render :action => 'new'
    end
  end

  def edit
    @family_card = FamilyCard.find(params[:id])
  end

  def update
    @family_card = FamilyCard.find(params[:id])
    if @family_card.update_attributes(params[:family_card])
      redirect_to @family_card, :notice  => "Successfully updated family card."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @family_card = FamilyCard.find(params[:id])
    @family_card.destroy
    redirect_to family_cards_url, :notice => "Successfully destroyed family card."
  end
end
