require File.dirname(__FILE__) + '/../spec_helper'

describe Parent do
  it { should belong_to(:family_card) }

  context "instance methods" do
    subject { create(:parent, :first_name => "Jimmy", :last_name => "Buffet") }

    describe "#name" do
      it "returns a string of the parent's first and last name" do
        subject.name.should == "Jimmy Buffet"
      end
    end
  end
end
