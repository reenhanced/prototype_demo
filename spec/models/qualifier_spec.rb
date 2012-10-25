require File.dirname(__FILE__) + '/../spec_helper'

describe Qualifier do
  it { should have_many(:family_card_qualifiers).dependent(:destroy) }
  it { should have_many(:family_cards) }

  it { should be_audited }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should ensure_inclusion_of(:category).in_array(Qualifier::CATEGORIES) }

  context "scopes" do
    describe ".ordered" do
      subject { Qualifier.ordered }

      let!(:second) { create(:qualifier, position: 2) }
      let!(:first)  { create(:qualifier, position: 1) }
      let!(:third)  { create(:qualifier, position: 3) }

      it { should == [first, second, third] }
    end
  end

  context "class methods" do
    subject { Qualifier }

    describe ".update_positions" do
      let!(:first)  { create(:qualifier, position: 1) }
      let!(:second) { create(:qualifier, position: 2) }
      let!(:third)  { create(:qualifier, position: 3) }
      let!(:fourth) { create(:qualifier, position: 4) }

      let(:ordered_ids) { [fourth.id, third.id, second.id, first.id] }

      it "updates the qualifiers specified by id so they will be returned in the proper order from Qualifier.ordered" do
        subject.update_positions(ordered_ids)

        subject.ordered.map(&:id).should == ordered_ids
      end
    end
  end

  context "instance methods" do
    subject { create(:qualifier, category: 'positive', name: 'Hugs bunnies') }
    let(:name) { subject.name }
    let(:category) { subject.category }

    describe "#to_s" do
      its(:to_s) { should == "[positive] Hugs bunnies" }
    end
  end
end
