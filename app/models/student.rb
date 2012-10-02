class Student < ActiveRecord::Base
  belongs_to :family_card, autosave: true
  has_many   :calls, :class_name => 'CallLog', :as => :contact

  RELATIONSHIPS          = ['Prospective Student', 'Sibling', 'Mother', 'Father',
                            'Paternal Grandmother', 'Paternal Grandfather', 'Maternal Mother',
                            'Maternal Father', 'Step Mother', 'Step Father', 'Foster Mother',
                            'Foster Father', 'Staff']
  BIRTHDAY_YEAR_OFFSET   = 20
  GRADUATION_YEAR_OFFSET = 20

  attr_accessible :first_name, :last_name, :relationship, :gender, :birthday, :graduation_year, :email, :phone, :address1, :address2, :city, :state, :zip_code

  def name
    "#{first_name} #{last_name}"
  end
end
