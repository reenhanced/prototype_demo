require 'spec_helper'

describe AuditDecorator do
  context "instance methods" do
    let!(:user)                 { create(:user, email: 'testerson@example.com', name: 'Testy Testerson') }
    let(:family_card)           { create(:family_card, user: user) }
    let(:changes_table_heading) { "<thead><tr><th>Changed</th><th>From</th><th>To</th></tr></thead>" }
    let(:audit)                 { Audit.with_associated_for(family_card).last }
    subject                     { AuditDecorator.decorate(audit) }

    before(:each) do
      # the audited gem uses the current user, so we fake for the specs
      subject.stub(:user).and_return(user)
    end

    describe "#action" do
      it "returns a string of the audited action and class name" do
        subject.action.should == 'Created Family Card'
      end
    end

    describe "#changes" do
      let!(:action)        { subject.action }
      let!(:changes_table) { subject.changes_table }

      its(:changes) { should include(action) }
      its(:changes) { should include(changes_table_heading) }

    end

    describe "#changes_table" do
      its(:changes_table) { should include(changes_table_heading) }
    end

    describe "#author" do
      let!(:audit_created_at) { Audit.human_attribute_name(:created_at, datetime: audit.created_at) }

      its(:author) { should include(audit_created_at) }

      context "with username" do
        before { subject.audit.stub(:user).and_return(user) }
        its(:author) { should include(user.name) }
        its(:author) { should include(user.email) }
      end

      context "without username" do
        its(:author) { should include('System') }
      end
    end

    describe "#author_name" do
    end

    describe "#name" do
      let!(:auditable_name) { subject.audit.auditable.to_s }
      let!(:revision_name)  { subject.audit.revision.to_s }

      context "with existing audited object" do
        its(:name) { should == auditable_name }
      end

      context "with no longer existing audited object" do
        before do
          audit.auditable.destroy
          audit.reload
        end

        its(:name) { should == revision_name }
      end
    end
  end
end
