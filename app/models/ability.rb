class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_admin?
        can :manage, :all
    else
        can :read, :all
    end

    if user.is_team?
        can :manage, Contest
    end

  end
end
