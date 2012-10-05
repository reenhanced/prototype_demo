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
end
