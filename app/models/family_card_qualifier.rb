class FamilyCardQualifier < ActiveRecord::Base
  belongs_to :family_card
  belongs_to :qualifier

  audited :associated_with => :family_card

  def to_s
    "\"#{qualifier.name}\" for #{family_card.name}"
  end
end
