require File.dirname(__FILE__) + '/../spec_helper'

describe Qualifier do
  it { should have_many(:family_card_qualifiers).dependent(:destroy) }
  it { should have_many(:family_cards) }

  it { should be_audited }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should ensure_inclusion_of(:category).in_array(Qualifier::CATEGORIES) }

  context "instance methods" do
    subject { create(:qualifier, category: 'positive', name: 'Hugs bunnies') }
    let(:name) { subject.name }
    let(:category) { subject.category }

    describe "#to_s" do
      its(:to_s) { should == "[positive] Hugs bunnies" }
    end
  end
end
