class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    else
      can :read, :all
    end


    can :manage, Question, user_id: user.id
    can :manage, Answer, user_id: user.id


  end
end
