class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    visitor_abilities

    if @user.present?
      any_user_abilities
      @user.roles.each { |role| abilities_for(role) }
    end
  end

  private

  def abilities_for(role)
    case role.to_sym
    when :admin
      admin_abilities
    end
  end

  def admin_abilities
    can :manage, :all
    can :browse, :all_family_cards
  end

  def any_user_abilities
    can :manage, FamilyCard,   :user_id => @user.id
    can :manage, FamilyMember, :family_card => { :user_id => @user.id }
    can :manage, CallLog,      :family_card => { :user_id => @user.id }

    can :read, FamilyCard
    can :read, Qualifier
  end

  def visitor_abilities
    can :read, User
  end
end
