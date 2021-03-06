require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject    { Ability.new(user) }

  shared_examples_for "cannot perform admin abilities" do
    it { should_not be_able_to(:create, User.new) }
    it { should_not be_able_to(:update, User.new) }
    it { should_not be_able_to(:destroy, User.new) }

    it { should_not be_able_to(:create, Qualifier.new) }
    it { should_not be_able_to(:update, Qualifier.new) }
    it { should_not be_able_to(:destroy, Qualifier.new) }

    it { should_not be_able_to(:read, Audited) }
  end

  context "for visitors" do
    let(:user) { nil }

    context "FamilyCard" do
      it { should_not be_able_to(:read, FamilyCard.new) }
      it { should_not be_able_to(:create, FamilyCard.new) }
      it { should_not be_able_to(:update, FamilyCard.new) }
      it { should_not be_able_to(:destroy, FamilyCard.new) }
    end

    context "FamilyMember" do
      it { should_not be_able_to(:create, FamilyMember.new) }
      it { should_not be_able_to(:read, FamilyMember.new) }
      it { should_not be_able_to(:update, FamilyMember.new) }
      it { should_not be_able_to(:destroy, FamilyMember.new) }
    end

    context "CallLog" do
      it { should_not be_able_to(:create, CallLog) }
      it { should_not be_able_to(:read, CallLog) }
      it { should_not be_able_to(:update, CallLog) }
      it { should_not be_able_to(:destroy, CallLog) }
    end

    it_behaves_like "cannot perform admin abilities"
  end

  context "for users without role" do
    let(:user) { build(:user) }
    let(:my_family_card)     { create(:family_card, user: user) }
    let(:your_family_card)   { create(:family_card, user: create(:user)) }

    it_behaves_like "cannot perform admin abilities"

    context "FamilyCard" do
      it { should be_able_to(:manage, FamilyCard.new) }

      it { should be_able_to(:manage, my_family_card) }

      it { should be_able_to(:index, your_family_card) }
      it { should_not be_able_to(:show, your_family_card) }
      it { should_not be_able_to(:create, your_family_card) }
      it { should_not be_able_to(:update, your_family_card) }
      it { should_not be_able_to(:destroy, your_family_card) }
    end

    context "FamilyMember" do
      let(:my_family_member)   { my_family_card.family_members.first }
      let(:your_family_member) { your_family_card.family_members.first }

      it { should be_able_to(:manage, my_family_member) }

      it { should_not be_able_to(:manage, your_family_member) }
    end

    context "CallLog" do
      let(:my_call_log)   { create(:call_log, family_card: my_family_card) }
      let(:your_call_log) { create(:call_log, family_card: your_family_card) }

      it { should be_able_to(:manage, my_call_log) }

      it { should_not be_able_to(:read, your_call_log) }
      it { should_not be_able_to(:create, your_call_log) }
      it { should_not be_able_to(:update, your_call_log) }
      it { should_not be_able_to(:destroy, your_call_log) }
    end

    context "Qualifier" do
      it { should be_able_to(:read, Qualifier.new) }
    end

  end

  context "for admin users" do
    let(:user) { build(:user, :admin) }

    it { should be_able_to(:manage, :all) }
    it { should be_able_to(:browse, :all_family_cards) }
  end
end
