require 'spec_helper'

describe Audit do
  it { should be_kind_of(Audited::Adapters::ActiveRecord::Audit) }

  it "is defined as the Audit class for Audited" do
    Audited.audit_class.should == Audit
  end

  context "class methods" do
    describe ".with_associated_for" do
      subject { Audit.with_associated_for(auditor) }

      context "with audits and associated audits" do
        let!(:auditor)  { create(:family_card) }
        let!(:parent)   { create(:parent, family_card: auditor) }
        let!(:student)  { create(:student, family_card: auditor) }

        let(:audits)            { auditor.audits }
        let(:associated_audits) { auditor.associated_audits }

        it { should include(*associated_audits) }
        it { should include(*audits) }
      end

      context "if no auditor is provided" do
        let (:auditor) { nil}

        it { should == [] }
      end
    end
  end
end
