require 'spec_helper'

describe FamilyCardsHelper do
  context "instance methods" do
    describe "#search_made?" do
      let(:params_without_search) { {action: "search", controller: "family_cards"} }
      let(:params_from_search) { {utf8: "&#x2713;", family_member: {first_name: "Willie Nelson"}} }

      it "should return true if any search params exist" do
        helper.stub!(:params).and_return(params_from_search)
        helper.family_card_search_made?.should be_true
      end

      it "should return false if no search params exist" do
        helper.stub!(:params).and_return(params_without_search)
        helper.family_card_search_made?.should be_false
      end
    end
  end
end
