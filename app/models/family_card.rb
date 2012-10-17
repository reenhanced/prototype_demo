class FamilyCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :default_parent, :class_name => 'FamilyMember', :foreign_key => :default_parent_id, :autosave => true
  has_many   :family_members, :autosave => true, :dependent => :nullify
  has_many   :students, :autosave => true, :dependent => :nullify
  has_many   :call_logs, :dependent => :destroy
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

  audited :associated_with => :default_parent
  has_associated_audits

  def self.find_all_from_search(params={})
    query    = nil
    params ||= {}

    # this chains where clauses using AND to match the combined search terms
    params.each do |key, value|
      if FamilyMember.attribute_names.include?(key.to_s) and value.present?
        if query.present?
          query = query.where(FamilyMember.arel_table[key].matches("%#{value}%"))
        else
          query = FamilyMember.select(:family_card_id).where(FamilyMember.arel_table[key].matches("%#{value}%"))
        end
      end
    end

    return [] if query.blank?
    card_ids = query.group('family_card_id').map(&:family_card_id)
    self.find(card_ids)
  end

  def name
    default_parent.name
  end
  alias_method :to_s, :name

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

  def audits_with_associated
    Audit.with_associated_for(self)
  end
end
