require File.dirname(__FILE__) + '/../spec_helper'

describe Qualifier do
  it { should have_many(:family_card_qualifiers) }
  it { should have_many(:family_cards) }
end
