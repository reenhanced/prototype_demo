require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCard do
  it { should belong_to(:user) }
  it { should belong_to(:default_parent).class_name('FamilyMember') }
  it { should belong_to(:default_student).class_name('Student') }
  it { should have_many(:family_members).dependent(:destroy) }
  it { should have_many(:students).dependent(:destroy).order('created_at ASC') }
  it { should have_many(:call_logs).dependent(:destroy) }
  it { should have_many(:family_card_qualifiers).dependent(:destroy) }
  it { should have_many(:qualifiers) }

  it { should have_associated_audits }

  delegated_fields = [ :first_name, :last_name,
                       :address1,   :address2,
                       :city,       :state,    :zip_code,
                       :email,      :phone,
                       :first_name=, :last_name=,
                       :address1=,   :address2=,
                       :city=,       :state=,    :zip_code=,
                       :email=,      :phone= ]
  delegated_fields.each do |delegated_field|
    it { should delegate(delegated_field).to(:default_parent).with_prefix(:parent) }
  end

  context "class methods" do
    let(:user)                { create(:user) }
    let(:family_card)         { create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Nelson") }
    let(:second_family_card)  { create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Jordan") }
    let(:valid_search_fields) { attributes_for(:family_member).keys }

    before :each do
      family_card
    end

    describe ".find_all_from_search" do
      it "returns an array of family cards that match any of the valid search fields" do
        valid_search_fields.each do |field|
          FamilyCard.find_all_from_search( {:"#{field}" => family_card.send(:"parent_#{field}")} ).should == [family_card]
        end
      end

      it "matches multiple search fields" do
        FamilyCard.find_all_from_search( first_name: family_card.parent_first_name, last_name: family_card.parent_last_name ).should == [family_card]
      end

      it "returns multiple matches" do
        first_card = family_card
        second_card = second_family_card

        FamilyCard.find_all_from_search( first_name: "Willie" ).should == [first_card, second_card]
      end

      it "ignores any blank fields" do
        FamilyCard.find_all_from_search( first_name: family_card.parent_first_name, last_name: "").should == [family_card]
      end

      it "returns an empty array if no family cards match the searches" do
        FamilyCard.find_all_from_search( first_name: "123456789ABC" ).should be_blank
        FamilyCard.find_all_from_search( money: "None" ).should be_blank
      end

      it "returns an empty array if no conditions are given" do
        FamilyCard.find_all_from_search().should be_blank
      end
    end
  end

  context "instance methods" do
    subject { create(:family_card, parent_first_name: "Jonny", parent_last_name: "Cash") }

    describe "#audits_with_associated" do
      before do
        Audit.stub(:with_associated_for).and_return("foo")
      end

      it "calls Audit.with_associated_for" do
        Audit.should_receive(:with_associated_for).with(subject)
        subject.audits_with_associated.should == 'foo'
      end
    end

    describe "#family_members" do
      before do
        2.times do
          create(:student, :family_card => subject)
          create(:parent, :family_card => subject)
        end
        subject.reload
      end

      it "returns all family members that are associated with the family card" do
        expect(subject.family_members).to have_exactly(5).family_members
      end
    end

    describe "#default_parent" do
      let(:family_card) { create(:family_card) }
      subject           { family_card.default_parent }

      describe "created by default" do
        let(:family_card) { FamilyCard.new }

        it { should be_an_instance_of(FamilyMember) }
      end

      describe "maintains relationships" do
        its(:family_card) { should == family_card }
      end
    end

    describe "#name" do
      it "returns the name for the default parent" do
        subject.name.should == FamilyCard.human_attribute_name(:name, family_name: subject.default_parent.last_name)
      end
    end

    describe "#to_s" do
      it "returns the name for the family card" do
        subject.to_s.should == subject.name
      end
    end
  end
end
