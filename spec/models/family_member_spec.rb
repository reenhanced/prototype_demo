require 'spec_helper'

describe FamilyMember do
  it { should belong_to(:family_card) }
  it { should have_many(:calls).class_name('CallLog') }

  context "instance methods" do
    subject { create(:family_member, :first_name => "Jimmy", :last_name => "Buffet") }

    describe "#name" do
      it "returns a string of the family members's first and last name" do
        subject.name.should == "Jimmy Buffet"
      end
    end
  end
end
