class FamilyCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :default_parent, :class_name => 'Parent', :foreign_key => :primary_parent_id, :autosave => true
  has_many   :parents, :autosave => true, :dependent => :nullify
  has_many   :students, :autosave => true, :dependent => :nullify
  has_many   :calls, :class_name => 'CallLog', :autosave => true, :dependent => :destroy

  attr_accessible :primary_parent_id, :parent_first_name, :parent_last_name, :student_name, :phone, :email, :address1, :address2, :city, :state, :zip_code
  accepts_nested_attributes_for :default_parent

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

  def default_parent_with_autobuild
    parent = default_parent_without_autobuild
    if parent.blank?
      parent = build_default_parent
    end

    parent
  end
  alias_method_chain :default_parent, :autobuild

  def email=(address)
    self.default_parent.email = address
    write_attribute(:email, address)
  end

  def phone=(number)
    self.default_parent.phone = number
    write_attribute(:phone, number)
  end

  def parent_first_name=(name)
    self.default_parent.first_name = name
    write_attribute(:parent_first_name, name)
  end

  def parent_last_name=(name)
    self.default_parent.last_name = name
    write_attribute(:parent_last_name, name)
  end

  def parent_name
    "#{parent_first_name} #{parent_last_name}"
  end

  def contacts
    self.parents(true) + self.students(true)
  end
end
