require File.dirname(__FILE__) + '/../spec_helper'

describe Parent do
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

  context "class methods" do
    let(:parent_relationships) do
      [
         'Sibling', 'Mother', 'Father',
         'Paternal Grandmother', 'Paternal Grandfather', 'Maternal Mother',
         'Maternal Father', 'Step Mother', 'Step Father', 'Foster Mother',
         'Foster Father', 'Staff'
      ]
    end
    describe ".relationships" do
      it "returns an array of relationship types for a parent" do
        Parent.relationships.should have(parent_relationships.count).relationships
        Parent.relationships.each do |relationship|
          parent_relationships.should include(relationship)
        end
      end
    end
  end
end
