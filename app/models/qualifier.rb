class Qualifier < ActiveRecord::Base
  has_many :family_card_qualifiers
  has_many :family_cards, :through => :family_card_qualifiers

  audited

  attr_accessible :name, :category, :position

  def to_s
    name
  end
end
