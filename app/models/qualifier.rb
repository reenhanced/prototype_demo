class Qualifier < ActiveRecord::Base
  CATEGORIES = %w{positive neutral negative}.freeze

  has_many :family_card_qualifiers, :dependent => :destroy
  has_many :family_cards, :through => :family_card_qualifiers

  audited

  validates :name, :presence => true, :uniqueness => true
  validates :category, :inclusion => CATEGORIES

  attr_accessible :name, :category, :position

  def self.ordered
    order(:position)
  end

  def self.update_positions(ids_array)
    ids_array.each_with_index do |qualifier_id, position|
      Qualifier.update_all({:position => position}, :id => qualifier_id)
    end
  end

  def to_s
    "[#{self.category}] #{self.name}"
  end
end
