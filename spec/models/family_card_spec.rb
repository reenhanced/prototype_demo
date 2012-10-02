require File.dirname(__FILE__) + '/../spec_helper'

describe FamilyCard do
  it { should belong_to(:user) }
  it { should belong_to(:default_parent).class_name('Parent') }
  it { should have_many(:students) }
  it { should have_many(:parents) }
  it { should have_many(:calls).class_name('CallLog') }
  it { should have_many(:qualifiers) }

  context "validations" do
    let!(:family_card) { create(:family_card) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:phone) }
  end

  context "callbacks" do
    subject { create(:family_card) }
    let(:new_family_card) { FamilyCard.new attributes_for(:family_card) }
    let!(:new_family_card_attributes) { attributes_for(:family_card) }
    let(:syncable_attributes) do
      {
        parent_first_name: :first_name,
        parent_last_name:  :last_name,
        email: :email,
        phone: :phone
      }
    end

    describe "#before_save" do
      it "builds a new parent for the family card" do
        new_family_card.default_parent.should_not be

        new_family_card.save!
        new_family_card.default_parent.should be
        new_family_card.primary_parent_id.should == new_family_card.default_parent.id
      end

      it "syncs the default parent data" do
        syncable_attributes.each do |family_card_attribute, parent_attribute|
          subject.send(:"#{family_card_attribute.to_s}=", new_family_card_attributes[family_card_attribute])
        end

        subject.save!
        syncable_attributes.each do |family_card_attribute, parent_attribute|
          subject.default_parent.send(:"#{parent_attribute}").should == new_family_card_attributes[family_card_attribute]
        end
      end
    end
  end

  context "class methods" do
    let(:user)                { create(:user) }
    let(:family_card)         { create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Nelson") }
    let(:second_family_card)  { create(:family_card, user: user, parent_first_name: "Willie", parent_last_name: "Jordan") }
    let(:valid_search_fields) { attributes_for(:family_card).keys }

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
    subject { create(:family_card, parent_first_name: "Willie", parent_last_name: "Nelson") }

    describe "#parent_name" do
      it "returns the parent's first and last name" do
        subject.parent_name.should == "Willie Nelson"
      end
    end

    describe "#contacts" do
      before do
        2.times do
          create(:student, :family_card => subject)
          create(:parent, :family_card => subject)
        end
        subject.reload
      end

      it "returns all students and parents associated with the family card" do
        subject.contacts.should have(5).contacts
        subject.students.each {|student| subject.contacts.should include(student) }
        subject.parents.each {|parent| subject.contacts.should include(parent) }
      end
    end

    describe "#has_qualifier?()" do
      subject { create(:family_card, parent_first_name: "Willie", parent_last_name: "Nelson") }
      let(:positive_qualifier) { create(:qualifier, :family_card => nil, category: 'positive') }
      let(:negative_qualifier) { create(:qualifier, :family_card => nil, category: 'negative') }

      it "returns true if the family card has a qualifier with the given name" do
        subject.qualifiers.build positive_qualifier.attributes.reject {|k,v| ['id', 'created_at', 'updated_at'].include?(k) }
        subject.save!

        subject.reload
        subject.has_qualifier?(positive_qualifier.name).should be_true
      end

      it "returns false if the familay card has no qualifiers matching the given name" do
        subject.has_qualifier?(positive_qualifier.name).should be_false
        subject.qualifiers.build negative_qualifier.attributes.reject {|k,v| ['id', 'created_at', 'updated_at'].include?(k) }
        subject.save!

        subject.reload
        subject.has_qualifier?(positive_qualifier.name).should be_false
      end
    end
  end
end
