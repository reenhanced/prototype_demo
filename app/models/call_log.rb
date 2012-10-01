class CallLog < ActiveRecord::Base
  belongs_to :family_card

  attr_accessible :family_card_id, :message
end
