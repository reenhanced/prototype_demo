class Parent < ActiveRecord::Base
  belongs_to :family_card
  has_many   :calls, :class_name => 'CallLog', :as => :contact

  attr_accessible :first_name, :last_name, :email, :phone

  def name
    "#{first_name} #{last_name}"
  end
end
