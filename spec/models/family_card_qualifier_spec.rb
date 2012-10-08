require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCardQualifier do
  it { should belong_to(:family_card) }
  it { should belong_to(:qualifier) }

  it { should be_audited.associated_with(:family_card) }
end
