require File.dirname(__FILE__) + '/../spec_helper'

describe Student do
  it { should be_kind_of(FamilyMember) }
  it { should have_db_column(:gender).of_type(:string).with_options(:limit => 1) }
end
