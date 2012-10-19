require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCardQualifier do
  it { should belong_to(:family_card) }
  it { should belong_to(:qualifier) }

  it { should be_audited.associated_with(:family_card) }

  context "instance methods" do
    let(:family_card) { create(:family_card) }
    let(:qualifier)   { create(:qualifier) }

    describe "#to_s" do
      it "returns the qualifier and family name" do
        subject = create(:family_card_qualifier, family_card: family_card, qualifier: qualifier)
        subject.to_s.should == "\"#{qualifier.name}\" to #{family_card.name}"
      end
    end
  end
end
