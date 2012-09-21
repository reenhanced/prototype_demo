module FamilyCardsHelper
  def family_card_search_made?
    params[:family_card].present?
  end
end
