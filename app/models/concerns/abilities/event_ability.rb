module Abilities
  module EventAbility
    def define_event_abilities_for_admin(user)
      can :manage, Event, company_id: user.company_id
    end

    def define_event_abilities_for_employee(user)
      can :read, Event, company_id: user.company_id
    end
  end
end
