require File.dirname(__FILE__) + '/../spec_helper'

describe Student do
  it { should be_kind_of(FamilyMember) }

  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:address1) }
  it { should allow_mass_assignment_of(:address2) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:state) }
  it { should allow_mass_assignment_of(:zip_code) }
  it { should allow_mass_assignment_of(:gender) }
  it { should allow_mass_assignment_of(:birthday) }
  it { should allow_mass_assignment_of(:graduation_year) }

  it { should_not allow_mass_assignment_of(:family_card_id) }

  context "instance methods" do
    describe "#default?" do
      let(:family_card)      { create(:family_card) }
      let(:default_student) { create(:student, family_card: family_card) }
      let(:another_student)  { create(:student, family_card: family_card) }

      before do
        family_card.default_student = default_student
        family_card.save!
      end

      it "returns true if the student is the default student for the family card" do
        default_student.default?.should be_true
      end

      it "returns false if the student is not the default student for the family card" do
        another_student.default?.should be_false
      end
    end
  end

end
