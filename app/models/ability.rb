class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.try(:admin?)
        can :manage, :all

    elsif user.try(:leader?)
        can :manage, User, location_id: user.try(:location_id)
        can :manage, Cohort, location_id: user.try(:location_id)
        can :manage, Pairing, cohort: { location_id: user.try(:location_id) }
        can :manage, Commitment, cohort: { location_id: user.try(:location_id) }
        can :manage, Message, user: { location_id: user.try(:location_id) }
    else
        can :manage, User, id: user.try(:id)
        can :manage, Commitment, user_id: user.try(:id)
    end
  end
end