class CallLog < ActiveRecord::Base
  belongs_to :family_card
  belongs_to :contact, :polymorphic => true

  delegate :qualifier_ids, :qualifier_ids=, :to => :family_card

  attr_accessible :family_card_id, :message, :contact_id, :contact_type, :qualifier_ids, :recorded_at

  validates :message, :presence => true
end
