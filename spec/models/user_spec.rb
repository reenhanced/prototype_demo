require 'spec_helper'

describe User do
  it { should have_many(:family_cards) }

  context "instance methods" do
    subject                  { create(:user) }
    let(:another_user)       { create(:user) }
    let(:my_family_card)     { create(:family_card, user: subject) }
    let(:not_my_family_card) { create(:family_card, user: another_user) }

    describe "#owns?" do
      it "returns true if the supplied object's user is the same as the current one" do
        subject.owns?(my_family_card).should be_true
      end

      it "returns false if the supplied object's user is not the same as the current one" do
        subject.owns?(not_my_family_card).should be_false
      end

      it "returns false if the supplied object doesn't respond to 'user'" do
        subject.owns?("oh no you don't!").should be_false
      end
    end
  end
end
