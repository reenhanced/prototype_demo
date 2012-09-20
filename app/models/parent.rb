class Parent < ActiveRecord::Base
  belongs_to :family_card
  attr_accessible :first_name, :last_name, :email, :phone

  def name
    "#{first_name} #{last_name}"
  end
end
