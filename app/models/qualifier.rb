class Qualifier < ActiveRecord::Base
  has_many :family_card_qualifiers
  has_many :family_cards, :through => :family_card_qualifiers

  audited

  attr_accessible :name, :category, :position, :family_card_id

  def to_s
    "[#{self.category}] #{self.name}"
  end
end
