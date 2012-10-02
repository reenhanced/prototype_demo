class Qualifier < ActiveRecord::Base
  belongs_to :family_card

  attr_accessible :name, :category, :position, :family_card_id

  scope :available, where(:family_card_id => nil)
end
