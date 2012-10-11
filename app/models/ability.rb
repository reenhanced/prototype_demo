class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new

    guest_abilities
    @user.roles.each { |role| abilities_for(role) }
  end

  protected

  def abilities_for(role)
    case role.to_sym
    when :admin
      can :manage, :all
    when :sales
      sales_abilities
    end
  end

  def sales_abilities
    can :manage, FamilyCard, :user_id => @user.id
    can :manage, FamilyMember, :family_card => { :user_id => @user.id }

    can :read, FamilyCard
    can :read, Qualifier
  end

  def guest_abilities
  end
end
