require File.dirname(__FILE__) + '/../spec_helper'

describe Student do
  it { should have_db_column(:gender).of_type(:string).with_options(:limit => 1) }
  it { should belong_to(:family_card) }
  it { should have_many(:calls).class_name('CallLog') }
end
