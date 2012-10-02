class CallLog < ActiveRecord::Base
  belongs_to :family_card
  belongs_to :contact, :polymorphic => true

  attr_accessible :family_card_id, :message, :contact_id, :contact_type

  validates :message, :presence => true
end
