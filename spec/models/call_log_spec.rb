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
end
