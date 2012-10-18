require File.dirname(__FILE__) + '/../spec_helper'

describe Qualifier do
  it { should have_many(:family_card_qualifiers) }
  it { should have_many(:family_cards) }

  it { should be_audited }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
