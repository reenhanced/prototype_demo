require 'spec_helper'

describe FamilyMember do
  it { should belong_to(:family_card) }
  it { should have_many(:calls).class_name('CallLog') }

  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:address1) }
  it { should allow_mass_assignment_of(:address2) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:state) }
  it { should allow_mass_assignment_of(:zip_code) }

  it { should_not allow_mass_assignment_of(:family_card_id) }

  context "instance methods" do
    subject { create(:family_member, :first_name => "Jimmy", :last_name => "Buffet") }

    describe "#name" do
      it "returns a string of the family members's first and last name" do
        subject.name.should == "Jimmy Buffet"
      end
    end

    describe "#to_s" do
      it "returns a string of the family member's name" do
        subject.to_s.should == "Jimmy Buffet"
      end
    end
  end
end
