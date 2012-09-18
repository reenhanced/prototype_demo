require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCard do
  it "should be valid" do
    FamilyCard.new.should be_valid
  end
end
