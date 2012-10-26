require File.dirname(__FILE__) + '/../spec_helper'

describe CallLog do
  it { should belong_to(:family_card) }
  it { should belong_to(:contact) }

  it { should delegate(:qualifier_ids).to(:family_card) }
  it { should delegate(:qualifier_ids=).to(:family_card) }

  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:contact_id) }
  it { should validate_presence_of(:contact_type) }

  it { should be_audited.associated_with(:family_card) }

  context "scopes" do
    describe "default" do
      let(:family_card) { create(:family_card) }

      it "orders by recorded_at descending" do
        first_call  = create(:call_log, family_card: family_card, recorded_at: DateTime.now)
        second_call = create(:call_log, family_card: family_card, recorded_at: DateTime.now + 2.days)

        CallLog.all.first.should == second_call
        CallLog.all.last.should  == first_call
      end
    end
  end

  context "instance methods" do
    let(:family_card) { create(:family_card) }
    subject           { create(:call_log, :with_qualifiers, family_card: family_card, contact_id: family_card.default_parent.id, contact_type: family_card.default_parent.class.to_s) }

    describe "#to_s" do
      its(:to_s) { should == "Spoke to: #{family_card.default_parent}" }
    end

    describe "#qualifiers" do
      it "returns an array of qualifiers descending by category for the associated family_card" do
        subject.qualifier_ids |= [create(:qualifier, category: 'neutral').id]
        subject.save!

        subject.reload
        subject.qualifiers.should have(4).qualifiers
        subject.qualifiers.first.category.should == 'positive'
        subject.qualifiers.last.category.should == 'negative'
      end
    end
  end
end
