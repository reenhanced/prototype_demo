require File.dirname(__FILE__) + '/../spec_helper'

describe CallLog do
  it { should belong_to(:family_card) }
end
