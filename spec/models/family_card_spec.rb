require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCard do
  it { should belong_to(:user) }
  it { should have_one(:default_parent).class_name('Parent') }

  context "class methods" do
    let(:user)                { FactoryGirl.create(:user) }
    let(:family_card)         { FactoryGirl.create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Nelson") }
    let(:second_family_card)  { FactoryGirl.create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Jordan") }
    let(:valid_search_fields) { FactoryGirl.attributes_for(:family_card).keys }

    describe ".find_all_from_search" do
      it "returns an array of family cards that match any of the valid search fields" do
        valid_search_fields.each do |field|
          FamilyCard.find_all_from_search( {:"#{field}" => family_card.send(:"#{field}")} ).should have(1).family_card
        end
      end

      it "matches multiple search fields" do
        FamilyCard.find_all_from_search( parent_first_name: family_card.parent_first_name, parent_last_name: family_card.parent_last_name ).should have(1).family_card
      end

      it "returns multiple matches" do
        first_card = family_card
        second_card = second_family_card

        FamilyCard.find_all_from_search( parent_first_name: "Willie" ).should have(2).family_cards
      end

      it "ignores any blank fields" do
        FamilyCard.find_all_from_search( parent_first_name: family_card.parent_first_name, parent_last_name: "").should have(1).family_card
      end

      it "returns an empty array if no family cards match the searches" do
        FamilyCard.find_all_from_search( parent_first_name: "123456789ABC" ).should be_blank
        FamilyCard.find_all_from_search( money: "None" ).should be_blank
      end
    end
  end
end
