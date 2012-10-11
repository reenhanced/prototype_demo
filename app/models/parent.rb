class Parent < FamilyMember
  def self.relationships
    RELATIONSHIPS.select {|r| r != 'Prospective Student'}
  end
end
