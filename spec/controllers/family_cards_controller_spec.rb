require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCardsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => FamilyCard.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    FamilyCard.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    FamilyCard.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(family_card_url(assigns[:family_card]))
  end

  it "edit action should render edit template" do
    get :edit, :id => FamilyCard.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    FamilyCard.any_instance.stubs(:valid?).returns(false)
    put :update, :id => FamilyCard.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    FamilyCard.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FamilyCard.first
    response.should redirect_to(family_card_url(assigns[:family_card]))
  end

  it "destroy action should destroy model and redirect to index action" do
    family_card = FamilyCard.first
    delete :destroy, :id => family_card
    response.should redirect_to(family_cards_url)
    FamilyCard.exists?(family_card.id).should be_false
  end
end
