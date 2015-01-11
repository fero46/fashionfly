class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      can :read, :all
      return
    end


    if user.is_admin?
        can :manage, :all
    else
        can :read, :all
      if user.is_team?
        can :manage, Contest
        can :manage, Banner
        can :manage, Shop
        can :manage, Property
      end
    end

  end
end
