require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCard do
  it { should belong_to(:user) }
  it { should have_one(:default_parent).class_name('Parent') }

  context "validations" do
    let!(:family_card) { FactoryGirl.create(:family_card) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:phone) }
  end

  context "callbacks" do
    let(:family_card) { FactoryGirl.create(:family_card) }
    let(:new_family_card) { FamilyCard.new FactoryGirl.attributes_for(:family_card) }
    let!(:new_family_card_attributes) { FactoryGirl.attributes_for(:family_card) }
    let(:syncable_attributes) do
      {
        parent_first_name: :first_name,
        parent_last_name:  :last_name,
        email: :email,
        phone: :phone
      }
    end

    before :each do
      # for some reason calling `family_card` in the it blocks returns nil
      @family_card = family_card
    end

    describe "#before_save" do
      it "builds a new parent for the family card" do
        new_family_card.default_parent.should_not be

        new_family_card.save!
        new_family_card.default_parent.should be
      end

      it "syncs the default parent data" do
        syncable_attributes.each do |family_card_attribute, parent_attribute|
          @family_card.send(:"#{family_card_attribute.to_s}=", new_family_card_attributes[family_card_attribute])
        end

        @family_card.save!
        syncable_attributes.each do |family_card_attribute, parent_attribute|
          @family_card.default_parent.send(:"#{parent_attribute}").should == new_family_card_attributes[family_card_attribute]
        end
      end
    end
  end

  context "class methods" do
    let(:user)                { FactoryGirl.create(:user) }
    let(:family_card)         { FactoryGirl.create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Nelson") }
    let(:second_family_card)  { FactoryGirl.create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Jordan") }
    let(:valid_search_fields) { FactoryGirl.attributes_for(:family_card).keys }

    before :each do
      family_card
    end

    describe ".find_all_from_search" do
      it "returns an array of family cards that match any of the valid search fields" do
        valid_search_fields.each do |field|
          FamilyCard.find_all_from_search( {:"#{field}" => family_card.send(:"#{field}")} ).should == [family_card]
        end
      end

      it "matches multiple search fields" do
        FamilyCard.find_all_from_search( parent_first_name: family_card.parent_first_name, parent_last_name: family_card.parent_last_name ).should == [family_card]
      end

      it "returns multiple matches" do
        first_card = family_card
        second_card = second_family_card

        FamilyCard.find_all_from_search( parent_first_name: "Willie" ).should == [first_card, second_card]
      end

      it "ignores any blank fields" do
        FamilyCard.find_all_from_search( parent_first_name: family_card.parent_first_name, parent_last_name: "").should == [family_card]
      end

      it "returns an empty array if no family cards match the searches" do
        FamilyCard.find_all_from_search( parent_first_name: "123456789ABC" ).should be_blank
        FamilyCard.find_all_from_search( money: "None" ).should be_blank
      end

      it "returns an empty array if no conditions are given" do
        FamilyCard.find_all_from_search().should be_blank
      end
    end
  end

  context "instance methods" do
    subject { FactoryGirl.create(:family_card, parent_first_name: "Willie", parent_last_name: "Nelson") }

    describe "#parent_name" do
      it "returns the parent's first and last name" do
        subject.parent_name.should == "Willie Nelson"
      end
    end
  end
end
