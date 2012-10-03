class FamilyCardQualifier < ActiveRecord::Base
  belongs_to :family_card
  belongs_to :qualifier
end
