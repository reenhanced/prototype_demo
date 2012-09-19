class FamilyCard < ActiveRecord::Base
  belongs_to :user
  has_one :default_parent, :class_name => 'Parent', :dependent => :nullify
  attr_accessible :parent_first_name, :parent_last_name, :student_name, :phone, :email, :address1, :address2, :city, :state, :zip_code

  def self.find_all_from_search(params={})
    conditions = {}
    params.each do |key, value|
      conditions[key] = value if params.respond_to?(key) and value.present?
    end
    FamilyCard.where(conditions)
    debugger
  end
end
