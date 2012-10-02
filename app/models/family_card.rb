class FamilyCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :default_parent, :class_name => 'Parent', :foreign_key => :primary_parent_id#, :autosave => true
  has_many   :parents, :autosave => true, :dependent => :nullify
  has_many   :students, :autosave => true, :dependent => :nullify
  has_many   :calls, :class_name => 'CallLog', :autosave => true, :dependent => :destroy
  has_many   :qualifiers, :autosave => true, :dependent => :destroy

  before_save :sync_default_parent, :except => [:create]
  before_create :create_default_parent

  attr_accessible :primary_parent_id, :parent_first_name, :parent_last_name, :student_name, :phone, :email, :address1, :address2, :city, :state, :zip_code
  accepts_nested_attributes_for :default_parent, :qualifiers

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

  def contacts
    self.parents(true) + self.students(true)
  end

  def has_qualifier?(qualifier_name)
    self.qualifiers.any? {|q| q.name == qualifier_name}
  end

  private
  def create_default_parent
    self.parents.first.save!
    self.default_parent = self.parents.first
  end

  def sync_default_parent
    self.default_parent = self.parents.first || self.parents.build unless self.default_parent
    SYNCABLE_PARENT_ATTRIBUTES.each do |family_card_attribute, parent_attribute|
      self.default_parent.send(:"#{parent_attribute}=", self.send(:"#{family_card_attribute}"))
    end
  end
end
