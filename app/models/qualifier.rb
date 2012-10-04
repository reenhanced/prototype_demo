class Qualifier < ActiveRecord::Base
  has_many :family_card_qualifiers
  has_many :family_cards, :through => :family_card_qualifiers

  attr_accessible :name, :category, :position, :family_card_id
end