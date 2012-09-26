class FamilyCard < ActiveRecord::Base
  belongs_to :user
  has_one    :default_parent, :class_name => 'Parent', :autosave => true, :dependent => :nullify
  has_many   :students, :autosave => true, :dependent => :nullify

  before_save :sync_default_parent

  attr_accessible :parent_first_name, :parent_last_name, :student_name, :phone, :email, :address1, :address2, :city, :state, :zip_code

  validates_uniqueness_of :email, :phone

  SYNCABLE_PARENT_ATTRIBUTES = {
    parent_first_name: :first_name,
    parent_last_name:  :last_name,
    email:             :email,
    phone:             :phone
  }

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

  private
  def sync_default_parent
    default_parent = build_default_parent unless default_parent
    SYNCABLE_PARENT_ATTRIBUTES.each do |family_card_attribute, parent_attribute|
      default_parent.send(:"#{parent_attribute}=", self.send(:"#{family_card_attribute}"))
    end
  end
end
