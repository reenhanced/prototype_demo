class FamilyMember < ActiveRecord::Base
  belongs_to :family_card
  has_many   :call_logs, :as => :contact

  attr_accessible :first_name, :last_name, :email, :phone, :address1, :address2, :city, :state, :zip_code, :relationship

  audited :associated_with => :family_card
  has_associated_audits

  RELATIONSHIPS = ['Prospective Student', 'Sibling', 'Mother', 'Father',
                   'Paternal Grandmother', 'Paternal Grandfather', 'Maternal Mother',
                   'Maternal Father', 'Step Mother', 'Step Father', 'Foster Mother',
                   'Foster Father', 'Staff']

  def self.non_students
    where "type != 'Student'"
  end

  def to_s
    name
  end

  def name
    "#{first_name} #{last_name}"
  end
end
