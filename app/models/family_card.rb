class FamilyCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :default_parent, :class_name => 'Parent', :foreign_key => :primary_parent_id, :autosave => true
  has_many   :family_members
  has_many   :parents, :autosave => true, :dependent => :nullify
  has_many   :students, :autosave => true, :dependent => :nullify
  has_many   :calls, :class_name => 'CallLog', :autosave => true, :dependent => :destroy
  has_many   :family_card_qualifiers
  has_many   :qualifiers, :through => :family_card_qualifiers

  delegate :first_name, :last_name,
           :address1,   :address2,
           :city,       :state,    :zip_code,
           :email,      :phone,
           :to => :default_parent, :prefix => :parent

  delegate :first_name=, :last_name=,
           :address1=,   :address2=,
           :city=,       :state=,    :zip_code=,
           :email=,      :phone=,
           :to => :default_parent, :prefix => :parent

  attr_accessible :parent_first_name, :parent_last_name, :parent_phone, :parent_email,
                  :parent_address1, :parent_address2, :parent_city, :parent_state, :parent_zip_code

  accepts_nested_attributes_for :default_parent

  def self.find_all_from_search(params={})
    conditions = {}
    params ||= {}
    params.each do |key, value|
      conditions[key] = value if FamilyMember.attribute_names.include?(key.to_s) and value.present?
    end

    return [] if conditions.blank?
    card_ids = FamilyMember.select(:family_card_id).where(conditions).group('family_card_id').map(&:family_card_id)
    self.find(card_ids)
  end

  def default_parent_with_autobuild(*args)
    parent = self.default_parent_without_autobuild(*args)
    if parent.nil?
      parent = build_default_parent
      parent.family_card = self
    end

    parent
  end
  alias_method_chain :default_parent, :autobuild

  def default_student
    students.first || students.build
  end
end
