require 'spec_helper'

describe User do
  it { should have_many(:family_cards) }

  context "instance methods" do
    subject          { create(:user) }
    let(:admin_user) { create(:user, :admin) }

    describe "#roles" do
      it "returns all roles for the given user" do
        admin_user.roles.should have(1).role
        admin_user.roles.should include('admin')
      end
    end

    describe "#roles=" do
      it "sets the roles for the user" do
        subject.roles.should be_empty
        subject.roles = ['admin']
        subject.save!

        subject.reload
        subject.roles.should have(1).role
        subject.roles.should include('admin')
      end

      it "doesn't allow setting of an undefined role" do
        subject.roles.should be_empty
        subject.roles = ['peakock']
        subject.save!

        subject.reload
        subject.roles.should be_empty
      end
    end

    describe "#is?" do
      it "returns true if the user has the given role" do
        admin_user.is?('admin').should be_true
        admin_user.is?(:admin).should be_true
      end

      it "returns false if the user doesn't have the given role" do
        admin_user.is?('peakock').should be_false
      end
    end

    describe "#username" do
      let!(:email) { subject.email }

      its(:username) { should == email }
    end
  end
end
