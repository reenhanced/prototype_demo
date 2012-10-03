class FamilyMember < ActiveRecord::Base
  belongs_to :family_card
  has_many   :calls, :class_name => 'CallLog', :as => :contact

  attr_accessible :first_name, :last_name, :email, :phone

  RELATIONSHIPS = ['Prospective Student', 'Sibling', 'Mother', 'Father',
                   'Paternal Grandmother', 'Paternal Grandfather', 'Maternal Mother',
                   'Maternal Father', 'Step Mother', 'Step Father', 'Foster Mother',
                   'Foster Father', 'Staff']
  def name
    "#{first_name} #{last_name}"
  end
end
