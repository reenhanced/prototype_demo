class FamilyCard < ActiveRecord::Base
  belongs_to :user
  has_one :default_parent, :class_name => 'Parent', :dependent => :nullify

  attr_accessible :parent_first_name, :parent_last_name, :student_name, :phone, :email, :address1, :address2, :city, :state, :zip_code

  validates_uniqueness_of :email, :phone
  def self.find_all_from_search(params={})
    conditions = {}
    params ||= {}
    params.each do |key, value|
      conditions[key] = value if self.attribute_names.include?(key.to_s) and value.present?
    end

    return [] if conditions.blank?
    FamilyCard.where(conditions)
  end

  def parent_name
    "#{parent_first_name} #{parent_last_name}"
  end
end
