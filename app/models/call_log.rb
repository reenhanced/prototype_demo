class CallLog < ActiveRecord::Base
  belongs_to :family_card
  belongs_to :contact, :polymorphic => true

  delegate :qualifier_ids, :qualifier_ids=, :to => :family_card

  default_scope order('recorded_at DESC')

  attr_accessible :message, :contact_id, :contact_type, :recorded_at

  validates :message, :presence => true

  audited :associated_with => :family_card
end
