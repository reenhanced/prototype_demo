class FamilyCardQualifier < ActiveRecord::Base
  belongs_to :family_card
  belongs_to :qualifier

  audited :associated_with => :family_card
end
