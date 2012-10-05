class CallLog < ActiveRecord::Base
  belongs_to :family_card
  belongs_to :contact, :polymorphic => true

  delegate :qualifier_ids, :qualifier_ids=, :to => :family_card

  attr_accessible :message, :contact_id, :contact_type, :recorded_at

  validates :message, :presence => true
end
