module FamilyCardsHelper
  def family_card_search_made?
    params[:family_member].present? and params[:utf8].present?
  end
end
