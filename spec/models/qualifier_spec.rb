require File.dirname(__FILE__) + '/../spec_helper'

describe Qualifier do
  it { should belong_to(:family_card) }

  context "scopes" do
    describe ".available" do
      let(:family_card)        { create(:family_card) }
      let!(:positive_qualifier) { create(:qualifier, family_card: nil, category: 'positive') }
      let!(:neutral_qualifier)  { create(:qualifier, family_card: nil, category: 'neutral') }
      let!(:negative_qualifier) { create(:qualifier, family_card: nil, category: 'negative') }

      before do
        create(:qualifier, family_card: family_card, category: 'positive')
        create(:qualifier, family_card: family_card, category: 'negative')
      end

      it "returns an array of qualifiers that are available for selection" do
        Qualifier.available.should have(3).qualifiers

        family_card.qualifiers.each do |qualifier|
          Qualifier.available.should_not include(qualifier)
        end
      end

    end
  end
end
