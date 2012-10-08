require File.dirname(__FILE__) + '/../spec_helper'

describe CallLog do
  it { should belong_to(:family_card) }
  it { should belong_to(:contact) }

  it { should delegate(:qualifier_ids).to(:family_card) }
  it { should delegate(:qualifier_ids=).to(:family_card) }

  it { should validate_presence_of(:message) }

  it { should be_audited.associated_with(:family_card) }
end
