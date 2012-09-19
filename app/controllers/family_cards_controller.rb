class FamilyCardsController < ApplicationController
  before_filter :find_family_card, :except => [:index, :new, :create, :search]

  def index
    @family_cards = FamilyCard.all
  end

  def search
    if request.post?
      @family_cards = FamilyCard.find_all_from_search(params[:family_card])
    end
  end

  def show
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
  end

  def update
    if @family_card.update_attributes(params[:family_card])
      redirect_to @family_card, :notice  => "Successfully updated family card."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @family_card.destroy
    redirect_to family_cards_url, :notice => "Successfully destroyed family card."
  end

  private
  def find_family_card
    @family_card = FamilyCard.find(params[:id])
  end
end
