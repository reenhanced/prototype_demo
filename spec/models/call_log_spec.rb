require File.dirname(__FILE__) + '/../spec_helper'

describe CallLog do
  it { should belong_to(:family_card) }
  it { should belong_to(:contact) }

  it { should delegate(:qualifier_ids).to(:family_card) }
  it { should delegate(:qualifier_ids=).to(:family_card) }

  it { should validate_presence_of(:message) }

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
    describe "#qualifiers" do
      let(:call_log) { create(:call_log, :with_qualifiers) }

      it "returns an array of qualifiers for the associated family_card" do
        call_log.qualifiers.should have(1).qualifier
      end
    end
  end
end
