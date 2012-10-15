require 'spec_helper'

describe Audit do
  it { should be_kind_of(Audited::Adapters::ActiveRecord::Audit) }
end
